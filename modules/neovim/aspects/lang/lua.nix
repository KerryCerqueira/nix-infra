{...}: {
  flake.wrappers.neovim = {
    pkgs,
    config,
    ...
  }: {
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
}
