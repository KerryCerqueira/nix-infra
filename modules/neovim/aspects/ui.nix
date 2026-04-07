{...}: {
  flake.wrappers.neovim = {
    pkgs,
    lib,
    config,
    ...
  }: let
    snacksTex = pkgs.texlive.combine {
      inherit
        (pkgs.texlive)
        preview
        standalone
        varwidth
        scheme-small
        ;
    };
  in {
    options.aspects.ui.enable =
      lib.mkEnableOption
      "UI features";
    config = lib.mkIf config.aspects.ui.enable {
      lazy = {
        plugins = {
          lualine-nvim = {
            name = "lualine.nvim";
            pkg = pkgs.vimPlugins.lualine-nvim;
          };
          snacks-nvim = {
            name = "snacks.nvim";
            pkg = pkgs.vimPlugins.snacks-nvim;
          };
          trouble-nvim = {
            name = "trouble.nvim";
            pkg = pkgs.vimPlugins.trouble-nvim;
          };
          which-key-nvim = {
            name = "which-key.nvim";
            pkg = pkgs.vimPlugins.which-key-nvim;
          };
        };
        specs = [
          (config.lazy.configSrc + "/lua/lazyspecs/ui.lua")
        ];
      };
      extraPackages = with pkgs; [
        ghostscript
        imagemagick
        mermaid-cli
        snacksTex
      ];
    };
  };
}
