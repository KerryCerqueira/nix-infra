{...}: {
  flake = {
    lib.wrapperModules.lazy-neovim = {
      pkgs,
      lib,
      wlib,
      config,
      ...
    }: {
      options.treesitter = {
        enable = lib.mkEnableOption "treesitter integration";
        pkg = lib.mkOption {
          type = lib.types.package;
          default = pkgs.vimPlugins.nvim-treesitter;
          description = "The nvim-treesitter package to use.";
        };
        grammars = lib.mkOption {
          type = lib.types.listOf lib.types.package;
          default = [];
          description = ''
            Treesitter grammar packages to bundle with nvim-treesitter.
            Each language aspect can append to this list.
          '';
        };
        withAllGrammars = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = ''
            Bundle all available grammars. Overrides the grammars list.
            Increases closure size significantly.
          '';
        };
      };
      config.specs.nvim-treesitter = {
        data = pkgs.vimPlugins.nvim-treesitter.withPlugins (_: config.treesitter.grammars);
      };
    };
  };
}
