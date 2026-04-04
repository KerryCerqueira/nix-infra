{
  self,
  inputs,
  ...
}: {
  flake = {
    wrappers.neovim = {...}: {
      imports = [self.wrapperModules.lazy-neovim];
      lazy.configSrc = ./src;
      lazy.configInitExtra = ''
        require("options").setup()
        require("keymaps").setup()
        require("autocommands").setup()
      '';
    };
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
  };
}
