{...}: {
  flake.wrappers.neovim = {
    pkgs,
    config,
    ...
  }: {
    extraPackages = with pkgs; [
      python312Packages.jupytext
      quarto
    ];
    hosts.python3.withPackages = pyPkgs:
      with pyPkgs; [
        cairosvg
        jupyter-client
        kaleido
        nbformat
        pnglatex
        plotly
        pyperclip
        pillow
        requests
        websocket-client
      ];
    lazy = {
      plugins = {
        img-clip-nvim = {
          name = "img-clip.nvim";
          pkg = pkgs.vimPlugins.img-clip-nvim;
        };
        molten-nvim = {
          name = "molten-nvim";
          pkg = pkgs.vimPlugins.molten-nvim;
        };
        otter-nvim = {
          name = "otter.nvim";
          pkg = pkgs.vimPlugins.otter-nvim;
        };
        quarto-nvim = {
          name = "quarto-nvim";
          pkg = pkgs.vimPlugins.quarto-nvim;
        };
        snacks-nvim = {
          name = "snacks.nvim";
          pkg = pkgs.vimPlugins.snacks-nvim;
        };
      };
      specs = [
        (config.lazy.configSrc + "/lua/lazyspecs/lang/ipynb.lua")
      ];
    };
    treesitter = {
      enable = true;
      grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        python
      ];
    };
  };
}
