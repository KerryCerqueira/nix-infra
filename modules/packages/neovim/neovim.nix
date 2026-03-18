{ self, ... }: {
  flake.wrappers.neovim = { ... }: {
    imports = [ self.wrapperModules.lazy ];
    lazy.configSrc = ./src/nvim;
    lazy.configInitExtra = ''
      require("options").setup()
      require("lazy-setup").setup()
      require("keymaps").setup()
      require("autocommands").setup()
    '';
  };
}
