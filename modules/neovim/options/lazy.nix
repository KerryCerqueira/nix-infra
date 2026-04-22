{self, ...}: {
  flake = {
    lib.wrapperModules.lazy-neovim = {
      pkgs,
      lib,
      wlib,
      config,
      ...
    }: let
      mkLazySpecFromFile = path:
        lib.generators.mkLuaInline
        "dofile(${lib.generators.toLua {} "${path}"})";
      mkLazySpecFromString = name: str: let
        file = pkgs.writeText "lazy-spec-${name}.lua" str;
      in
        mkLazySpecFromFile file;
      mkPluginSpec = _name: {
        pkg,
        name,
        ...
      }: {
        inherit name;
        dir = builtins.toString pkg;
      };
      mkLuaSpec = spec:
        if builtins.isPath spec
        then mkLazySpecFromFile spec
        else if builtins.isString spec
        then mkLazySpecFromString spec
        else if builtins.isAttrs spec
        then lib.generators.mkLuaInline (lib.generators.toLua {} spec)
        else throw "lazy.specs: expected path, string, or attrset";
      configDir = pkgs.runCommand "nvim-config" {} ''
        cp -rL --no-preserve=mode ${config.lazy.configSrc} $out
        cat > $out/init.lua << 'EOF'
        ${config.lazy.configInitExtra}
        ${config.lazy.configInit}
        EOF
      '';
      mkConvergentType = self.lib.mkConvergentType pkgs;
    in {
      imports = [wlib.wrapperModules.neovim];
      options = {
        lazy = {
          configSrc = lib.mkOption {
            type = lib.types.path;
            description = ''
              Path to the base neovim configuration directory. This should
              contain the nix-agnostic config tree (lua/, after/, ftplugin/,
              etc.). The init.lua in this directory will be replaced by the
              nix-generated one at build time.
            '';
          };
          configInit = lib.mkOption {
            type = mkConvergentType lib.types.lines;
            default = ''
              local nix_info = require(vim.g.nix_info_plugin_name)
              local specs = {}
              local lazy_specs = nix_info(nil, "info", "lazy_specs") or {}
              for _, spec in pairs(lazy_specs) do
                table.insert(specs, spec)
              end
              require("lazy").setup(specs, {
                install = { missing = false },
                performance = {
                  reset_packpath = false,
                  rtp = { reset = false, },
                },
              })
              for server, cfg in pairs(nix_info(nil, "info", "lsp_config") or {}) do
                vim.lsp.config(server, cfg)
                vim.lsp.enable(server)
              end
            '';
            description = "Lua code for primary init logic (e.g. lazy.nvim setup).";
          };
          configInitExtra = lib.mkOption {
            type = lib.types.lines;
            default = "";
            description = "Additional Lua code appended after configInit.";
          };
          plugins = lib.mkOption {
            type = lib.types.attrsOf (lib.types.submodule {
              options = {
                pkg = lib.mkOption {
                  type = mkConvergentType lib.types.package;
                  description = "Plugin derivation.";
                };
                name = lib.mkOption {
                  type = mkConvergentType lib.types.str;
                  description = ''
                    Plugin name used as the lazy.nvim merge key.
                  '';
                };
              };
            });
            default = {};
            description = "Plugin derivations to place on the packpath.";
          };
          specs = lib.mkOption {
            type = lib.types.listOf lib.types.anything;
            default = [];
            description = ''
              Lazy.nvim spec sources. Each element can be:
              # - a path to a lua file returning a lazy spec table (or list of specs)
              - a raw lua string evaluating to a spec table
              - an attrset of lazy.nvim fields translated via nixToLua
            '';
          };
        };
      };
      config = {
        hosts.python3.nvim-host.enable = true;
        specs.lazy-nvim = pkgs.vimPlugins.lazy-nvim;
        info.lazy_specs =
          (lib.mapAttrsToList mkPluginSpec config.lazy.plugins)
          ++ (map mkLuaSpec config.lazy.specs);
        settings.config_directory = configDir;
      };
    };
  };
}
