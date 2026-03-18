{...}: {
  flake.wrapperModules.lazy = {
    pkgs,
    lib,
    wlib,
    config,
    ...
  }: let
    mkLazySpecFromFile = path:
      lib.generators.mkLuaInline
      "dofile(${lib.generators.toLua {} (builtins.toString path)})";
    mkLazySpecFromString = name: str: let
      file = pkgs.writeText "lazy-spec-${name}.lua" str;
    in
      mkLazySpecFromFile file;
    mkLazySpec = attrName: {
      pkg,
      name,
      luaSpec ? null,
      ...
    }: let
      nixSpec =
        {
          inherit name;
          dir = builtins.toString pkg;
        }
        // (
          if builtins.isAttrs luaSpec
          then luaSpec
          else {}
        );

      luaFileSpec =
        if luaSpec == null
        then []
        else if builtins.isPath luaSpec
        then [(mkLazySpecFromFile luaSpec)]
        else if builtins.isString luaSpec
        then [(mkLazySpecFromString attrName luaSpec)]
        else []; # attrset case already folded into nixSpec
    in
      [nixSpec] ++ luaFileSpec;
    configDir = pkgs.runCommand "nvim-config" {} ''
      cp -rL --no-preserve=mode ${config.lazy.configSrc} $out
      cat > $out/init.lua << 'EOF'
      ${config.lazy.configInit}
      ${config.lazy.configInitExtra}
      EOF
    '';
  in {
    imports = [wlib.wrapperModules.neovim];
    options.lazy.specs = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule {
        options.pkg = lib.mkOption {
          type = lib.types.package;
          description = "Plugin derivation.";
        };
        options.name = lib.mkOption {
          type = lib.types.str;
          description = ''
            Plugin name used as the lazy.nvim merge key. Must match
            what lazy.nvim derives from the short URL in the pure-lua
            spec (typically the repo name after the /).
          '';
        };
        options.luaSpec = lib.mkOption {
          type = lib.types.nullOr (lib.types.oneOf [
            lib.types.path
            lib.types.str
            (lib.types.attrsOf lib.types.anything)
          ]);
          default = null;
          description = ''
            Additional lazy.nvim spec fields. Can be:
            - a path to a lua file returning a lazy spec table
            - a raw lua string (chunk) evaluating to a spec table
            - an attrset of lazy.nvim fields (opts, event, keys, etc.)
          '';
        };
      });
      default = {};
      description = "Lazy.nvim plugin specs to be read by lazy.nvim.";
    };
    options.lazy.configSrc = lib.mkOption {
      type = lib.types.path;
      description = ''
        Path to the base neovim configuration directory. This should
        contain the nix-agnostic config tree (lua/, after/, ftplugin/,
        etc.). The init.lua in this directory will be replaced by the
        nix-generated one at build time.
      '';
    };
    options.lazy.configInit = lib.mkOption {
      type = lib.types.lines;
      default = ''
        local nix_info = require(vim.g.nix_info_plugin_name)
        local specs = {}
        local lazy_specs = nix_info(nil, "info", "lazy_specs") or {}
        for _, spec in pairs(lazy_specs) do
          table.insert(specs, spec)
        end
        require("lazy").setup(specs, {
          install = { missing = false },
        })
      '';
      description = "Lua code for primary init logic (e.g. lazy.nvim setup).";
    };
    options.lazy.configInitExtra = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Additional Lua code appended after configInit.";
    };
    config.specs.lazy-nvim = pkgs.vimPlugins.lazy-nvim;
    config.info.lazy_specs =
      lib.concatLists (lib.mapAttrsToList mkLazySpec config.lazy.specs);
    config.settings.config_directory = configDir;
    config.settings.block_normal_config = true;
  };
}
