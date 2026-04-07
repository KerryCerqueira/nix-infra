{...}: {
  flake.wrappers.neovim = {
    pkgs,
    lib,
    config,
    ...
  }: {
    options.aspects.lang.python.enable =
      lib.mkEnableOption
      "python code editing features";
    config = lib.mkIf config.aspects.lang.python.enable {
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
  };
}
