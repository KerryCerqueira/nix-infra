{...}: {
  flake.wrappers.neovim = {
    pkgs,
    config,
    ...
  }: {
    extraPackages = with pkgs; [
      pyright
      ruff
    ];
    treesitter = {
      enable = true;
      grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        python
      ];
    };
  };
}
