{...}: {
  flake.wrappers.neovim = {
    pkgs,
    lib,
    config,
    ...
  }: {
    options.aspects.formatting.enable =
      lib.mkEnableOption
      "Formatting features";
    config = lib.mkIf config.aspects.formatting.enable {
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
    };
}
