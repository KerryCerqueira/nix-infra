{...}: {
  perSystem = {
    self',
    pkgs,
    ...
  }: {
    packages = {
      generate-luarc = let
        wrapperCfg = self'.packages.neovim.passthru.configuration;
        luarcJson = wrapperCfg.aspects.lang.lua.luarc;
      in
        pkgs.writeShellScriptBin "generate-luarc" ''
          cat <<'EOF' | ${pkgs.jq}/bin/jq .
          ${builtins.toJSON luarcJson}
          EOF
        '';
      prefetch-vim-plugin = pkgs.writeShellApplication {
        name = "prefetch-vim-plugin";
        runtimeInputs = with pkgs; [
          nix-prefetch-git
          jq
          coreutils
          gnugrep
        ];
        text = ''
          usage() {
            echo "Usage: prefetch-vim-plugin <github-url> [rev]" >&2
            exit 1
          }

          if [ $# -lt 1 ]; then
            usage
          fi

          repo_url="$1"
          rev="''${2:-HEAD}"

          stripped="''${repo_url##*github.com/}"
          owner="''${stripped%%/*}"
          repo_name=$(basename "$repo_url" .git)

          echo "Prefetching $repo_url at $rev..." >&2
          prefetch_json=$(nix-prefetch-git --quiet --fetch-submodules "$repo_url" --rev "$rev")
          src_hash=$(echo "$prefetch_json" | jq -r '.hash')
          actual_rev=$(echo "$prefetch_json" | jq -r '.rev')
          commit_date=$(echo "$prefetch_json" | jq -r '.date')

          version=""
          if echo "$rev" | grep -qE '^v?[0-9]'; then
            version="''${rev#v}"
          fi

          if [ -z "$version" ]; then
            version="unstable-$commit_date"
          fi

          cat <<EOF
          pkgs.vimUtils.buildVimPlugin {
            pname = "$repo_name";
            version = "$version";
            src = pkgs.fetchFromGitHub {
              owner = "$owner";
              repo = "$repo_name";
              rev = "$actual_rev";
              hash = "$src_hash";
            };
          }
          EOF
        '';
      };
    };
    devShells.default = pkgs.mkShell {
      packages = [
        (self'.packages.neovim.wrap {
          aspects.lang.lua.enable = true;
          aspects.lang.lua.passLuaRc = true;
          aspects.lang.nix.enable = true;
        })
      ];
    };
  };
}
