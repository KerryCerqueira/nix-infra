{
  self,
  inputs,
  ...
}: {
  flake = {
    nixosModules.neovim = {pkgs, ...}: {
      imports = [
        (inputs.nix-wrapper-modules.lib.mkInstallModule {
          loc = ["environment" "systemPackages"];
          name = "neovim";
          value = self.wrapperModules.neovim;
        })
      ];
      wrappers.neovim = {
        enable = true;
      };
      environment.variables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
    };
    homeModules.neovim = {pkgs, ...}: {
      imports = [
        (inputs.nix-wrapper-modules.lib.mkInstallModule {
          loc = ["home" "packages"];
          name = "neovim";
          value = self.wrapperModules.neovim;
        })
      ];
      wrappers.neovim = {
        enable = true;
        extraPackages = [pkgs.wl-clipboard];
        settings.block_normal_config = false;
      };
      home.sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
    };
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
          nix.enable = true;
        };
      };
    };
  };
}
