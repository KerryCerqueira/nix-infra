{
  self,
  inputs,
  ...
}: {
  flake = {
    homeConfigurations = {
      "kerry@counter" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.nixpkgs {system = "x86_64-linux";};
        modules = [
          {
            programs.homeManager.enable = true;
            home = {
              stateVersion = "25.05";
              username = "kerry";
              homeDirectory = "/home/kerry";
            };
          }
          inputs.nvim-config.homeManagerModules.nvim-config
          inputs.shell-config.homeManagerModules.shell-config
        ];
      };
      "kcerqueira@cruncher" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.nixpkgs {system = "x86_64-linux";};
        modules = [
          {
            programs.homeManager.enable = true;
            home = {
              stateVersion = "25.05";
              username = "kcerqueira";
              homeDirectory = "/home/kcerqueira";
            };
          }
          inputs.nvim-config.homeManagerModules.nvim-config
          inputs.shell-config.homeManagerModules.shell-config
        ];
      };
    };
    homeModules.kerry = {pkgs, ...}: {
      imports = with self.homeModules; [
        libreoffice
        zathura
        kitty
        inputs.nvim-config.homeManagerModules.nvim-config
        inputs.shell-config.homeManagerModules.shell-config
      ];
      programs = {
        home-manager.enable = true;
        firefox.enable = true;
      };
      home = {
        username = "kerry";
        homeDirectory = "/home/kerry";
        packages = with pkgs; [
          obsidian
          inkscape-with-extensions
          ipe
          keepassxc
          gimp
          discord
          slack
          thunderbird
          zoom-us
          teams-for-linux
          rnote
          vlc
          spotify
          whatsapp-for-linux
        ];
      };
    };
  };
}
