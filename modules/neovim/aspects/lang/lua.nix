{...}: {
  flake.wrappers.neovim = {
    pkgs,
    lib,
    config,
    ...
  }: {
    options.aspects.lang.lua.enable =
      lib.mkEnableOption
      "lua code editing features";
    config = lib.mkIf config.aspects.lang.lua.enable {
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
    };
  };
}
