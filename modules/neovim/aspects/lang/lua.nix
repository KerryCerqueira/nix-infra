{...}: {
  flake.wrappers.neovim = {
    pkgs,
    lib,
    config,
    ...
  }: {
    options = {
      aspects.lang.lua.enable =
        lib.mkEnableOption
        "lua code editing features";
      aspects.lang.lua.passLuaRc = lib.mkOption {
        type = lib.types.bool;
        description = "Whether to configure lua_ls with neovim plugin workspace.";
        default = false;
      };
      luarcJson = lib.mkOption {
        type = lib.types.str;
        readOnly = true;
        description = "Generated .luarc.json content.";
      };
    };
    config = lib.mkMerge [
      (lib.mkIf config.aspects.lang.lua.enable {
        extraPackages = with pkgs; [
          stylua
          lua-language-server
        ];
        lazy = {
          plugins = {
            conform-nvim = {
              name = "conform.nvim";
              pkg = pkgs.vimPlugins.conform-nvim;
            };
          };
          specs = [
            (config.lazy.configSrc + "/lua/lazyspecs/lang/lua.lua")
          ];
        };
        treesitter = {
          enable = true;
          grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
            lua
            luadoc
            luap
          ];
        };
      })
      {
        lazy.luarc = {
          runtime.version = "LuaJIT";
          workspace = {
            checkThirdParty = false;
            library =
              ["${config.package}/share/nvim/runtime/lua"]
              ++ ["${config.specs.lazy-nvim.data}/lua"]
              ++ map (p: "${p.pkg}/lua")
              (builtins.attrValues config.lazy.plugins);
          };
        };
      }
      (lib.mkIf config.aspects.lang.lua.passLuaRc {
        info.lsp_config.lua_ls = config.lazy.luarc;
      })
    ];
  };
}
