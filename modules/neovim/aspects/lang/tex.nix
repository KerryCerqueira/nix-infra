{...}: {
  flake.wrappers.neovim = {
    pkgs,
    lib,
    config,
    ...
  }: {
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
      lspConfig.texlab.pkg = pkgs.texlab;
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
