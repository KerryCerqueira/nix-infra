{pkgs, ...}: {
  programs.neovim = {
    extraPackages = with pkgs; [
      python312Packages.jupytext
      quarto
    ];
    extraPython3Packages = pyPkgs:
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
    plugins = with pkgs.vimPlugins; [
      img-clip-nvim
      molten-nvim
      nvim-lspconfig
      otter-nvim
      quarto-nvim
      snacks-nvim
    ];
  };
  xdg.configFile."nvim/lua/plugins/lang/ipynb.lua".source =
    ../../src/lua/plugins/lang/ipynb.lua;
}
