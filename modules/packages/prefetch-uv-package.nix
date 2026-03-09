{
  perSystem = {pkgs, ...}: {
    packages.prefetch-uv-package = pkgs.writeShellApplication {
      name = "prefetch-python-mcp";
      runtimeInputs = with pkgs; [
        git
        nix-prefetch-git
        jq
        yq
      ];
      text = ''
        usage() {
          echo "Usage: prefetch-python-mcp <git-url> [rev]" >&2
          echo "" >&2
          echo "  git-url   HTTPS URL of the git repository" >&2
          echo "  rev       Optional git rev (tag, branch, commit). Defaults to HEAD." >&2
          exit 1
        }

        if [ $# -lt 1 ]; then
          usage
        fi

        repo_url="$1"
        rev="''${2:-HEAD}"

        echo "Fetching git hash..." >&2
        prefetch_json=$(nix-prefetch-git --quiet --fetch-submodules "$repo_url" --rev "$rev")
        src_hash=$(echo "$prefetch_json" | jq -r '.hash')
        actual_rev=$(echo "$prefetch_json" | jq -r '.rev')

        owner=$(echo "$repo_url" | cut -d'/' -f4)
        repo_name=$(basename "$repo_url" .git)

        # Derive pname from repo name
        pname="$repo_name"

        # Try to extract the entrypoint from pyproject.toml in the fetched source
        store_path=$(echo "$prefetch_json" | jq -r '.path')
        entrypoint=""
        if [ -f "$store_path/pyproject.toml" ]; then
          entrypoint=$(tomlq -r '.project.scripts | keys[0]' "$store_path/pyproject.toml" 2>/dev/null || true)
        fi

        # Fall back to repo name if no entrypoint found
        if [ -z "$entrypoint" ]; then
          entrypoint="$repo_name"
        fi

        cat <<EOF
        packages.$pname = mkPythonMcp {
          pname = "$pname";
          entrypoint = "$entrypoint";
          src = pkgs.fetchFromGitHub {
            owner = "$owner";
            repo = "$repo_name";
            rev = "$actual_rev";
            hash = "$src_hash";
          };
        };
        EOF
      '';
    };
  };
}
