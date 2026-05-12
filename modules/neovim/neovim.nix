{
  self,
  inputs,
  ...
}: {
  flake = {
    nixosModules = {
      neovim = {pkgs, ...}: {
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
      claudius = {imports = [self.nixosModules.neovim];};
      panza = {imports = [self.nixosModules.neovim];};
      potato = {imports = [self.nixosModules.neovim];};
      napoleon = {imports = [self.nixosModules.neovim];};
    };
    homeModules = {
      neovim = {pkgs, ...}: {
        imports = [
          (inputs.nix-wrapper-modules.lib.mkInstallModule {
            loc = ["home" "packages"];
            name = "neovim";
            value = self.wrapperModules.neovim;
          })
        ];
        wrappers.neovim = {
          enable = true;
          settings.block_normal_config = false;
        };
        home.sessionVariables = {
          EDITOR = "nvim";
          VISUAL = "nvim";
        };
      };
      kerry = {imports = [self.homeModules.neovim];};
    };
  };
}
