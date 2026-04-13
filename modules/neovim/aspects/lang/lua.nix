{...}: {
  flake.wrappers.neovim = {
    pkgs,
    lib,
    config,
    ...
  }: {
    config = lib.mkIf config.aspects.lang.lua.enable {
      extraPackages = with pkgs; [stylua];
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
      lspConfig.lua_ls.pkg = pkgs.lua-language-server;
      treesitter = {
        enable = true;
        grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          lua
          luadoc
          luap
        ];
      };
    };
  };
}
