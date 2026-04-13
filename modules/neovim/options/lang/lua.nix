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
      aspects.lang.lua.luarc = lib.mkOption {
        type = lib.types.attrsOf lib.types.anything;
        default = {};
        description = "lua_ls configuration to be passed via info";
      };
      luarcJson = lib.mkOption {
        type = lib.types.str;
        readOnly = true;
        description = "Generated .luarc.json content.";
      };
    };
    config.info.lsp_config.lua_ls.settings.Lua =
      lib.mkIf
      config.aspects.lang.lua.passLuaRc
      {
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
  };
}
