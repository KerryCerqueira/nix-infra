{
  flake.perSystem.packages = {pkgs, ...}: {
    prefetch-npm-package = pkgs.writeShellApplication {
      name = "prefetch-npm-package";
      runtimeInputs = with pkgs; [
        git
        nodejs
        prefetch-npm-deps
        nix-prefetch-git
        nix
        jq
      ];

      text = ''
        usage() {
          echo "Usage: prefetch-npm-package <git-url> [rev]"
          echo ""
          echo "  git-url   HTTPS URL of the git repository"
          echo "  rev       Optional git rev (tag, branch, commit). Defaults to HEAD."
          exit 1
        }

        if [ $# -lt 1 ]; then
          usage
        fi

        repo_url="$1"
        rev="''${2:-HEAD}"

        tmp=$(mktemp -d)
        trap 'rm -rf "$tmp"' EXIT

        echo "Fetching git hash..." >&2
        prefetch_json=$(nix-prefetch-git --quiet --fetch-submodules "$repo_url" --rev "$rev")
        src_hash=$(echo "$prefetch_json" | jq -r '.hash')
        actual_rev=$(echo "$prefetch_json" | jq -r '.rev')
        repo_name=$(basename "$repo_url" .git)

        echo "Cloning into temp dir..." >&2
        git clone --quiet --depth 1 "$repo_url" --branch "$rev" "$tmp/src" 2>/dev/null \
          || (git clone --quiet "$repo_url" "$tmp/src" && git -C "$tmp/src" checkout --quiet "$actual_rev")

        if [ ! -f "$tmp/src/package-lock.json" ]; then
          echo "No package-lock.json found, generating..." >&2
          (cd "$tmp/src" && npm install --package-lock-only --ignore-scripts)
        fi

        echo "Computing npmDepsHash..." >&2
        if ! npm_hash=$(prefetch-npm-deps "$tmp/src/package-lock.json" 2>&1); then
          echo "prefetch-npm-deps failed: $npm_hash" >&2
          exit 1
        fi

        pkg_version="0.0.0"
        if [ -f "$tmp/src/package.json" ]; then
          pkg_version=$(jq -r '.version // "0.0.0"' "$tmp/src/package.json")
        fi

        cat <<EOF
        { buildNpmPackage, fetchFromGitHub }:

        buildNpmPackage {
          pname = "$repo_name";
          version = "$pkg_version";

          src = fetchFromGitHub {
            owner = "FIXME";
            repo = "$repo_name";
            rev = "$actual_rev";
            hash = "$src_hash";
          };

          npmDepsHash = "$npm_hash";

          # Remove or set to false if the package has a build step
          dontNpmBuild = true;
        }
        EOF
      '';
    };
  };
}
