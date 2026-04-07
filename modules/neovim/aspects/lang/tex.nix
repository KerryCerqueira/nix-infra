{...}: {
  flake.wrappers.neovim = {
    pkgs,
    lib,
    config,
    ...
  }: {
    options.aspects.lang.tex.enable =
      lib.mkEnableOption
      "TeX code editing features";
    config = lib.mkIf config.aspects.lang.tex.enable {
      extraPackages = with pkgs; [
        texlab
        texlivePackages.chktex
      ];
      lazy = {
        plugins = {
          vimtex = {
            name = "vimtex";
            pkg = pkgs.vimPlugins.vimtex;
          };
          nvim-lint = {
            name = "nvim-lint";
            pkg = pkgs.vimPlugins.nvim-lint;
          };
        };
        specs = [
          (config.lazy.configSrc + "/lua/lazyspecs/lang/tex.lua")
        ];
      };
      treesitter = {
        enable = true;
        grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bibtex
          latex
        ];
      };
    };
  };
}
