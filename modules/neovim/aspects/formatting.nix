{...}: {
  flake.wrappers.neovim = {
    pkgs,
    config,
    ...
  }: {
    lazy = {
      plugins = {
        nvim-lint = {
          name = "nvim-lint";
          pkg = pkgs.vimPlugins.nvim-lint;
        };
        conform-nvim = {
          name = "conform.nvim";
          pkg = pkgs.vimPlugins.conform-nvim;
        };
      };
      specs = [
        (config.lazy.configSrc + "/lua/lazyspecs/formatting.lua")
      ];
    };
  };
}
