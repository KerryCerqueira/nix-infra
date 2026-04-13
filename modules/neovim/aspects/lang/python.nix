{...}: {
  flake.wrappers.neovim = {
    pkgs,
    lib,
    config,
    ...
  }: {
    config = lib.mkIf config.aspects.lang.python.enable {
      lspConfig = {
        pyright.pkg = pkgs.pyright;
        ruff.pkg = pkgs.ruff;
      };
      treesitter = {
        enable = true;
        grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          python
        ];
      };
    };
  };
}
