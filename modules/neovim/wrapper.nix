{self, ...}: {
  flake = {
    wrappers.neovim = {...}: {
      imports = [self.lib.wrapperModules.lazy-neovim];
      lazy.configSrc = ./src;
      lazy.configInitExtra = ''
        require("options").setup()
        require("keymaps").setup()
        require("autocommands").setup()
      '';
      aspects = {
        appearance.enable = true;
        completion.enable = true;
        editing.enable = true;
        filetree.enable = true;
        formatting.enable = true;
        git.enable = true;
        picker.enable = true;
        treesitter.enable = true;
        ui.enable = true;
        lang = {
          sh.enable = true;
          mdlangs.enable = true;
          markdown.enable = true;
        };
      };
    };
  };
}
