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
          self.homeModules.nvim
          self.homeModules.shell
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
          self.homeModules.nvim
          self.homeModules.zsh
          self.homeModules.fish
          self.homeModules.shell-utils
        ];
      };
    };
    homeModules.kerry = {pkgs, ...}: {
      imports = with self.homeModules; [
        libreoffice
        zathura
        kitty
        self.homeModules.nvim
        self.homeModules.zsh
        self.homeModules.fish
        self.homeModules.shell-utils
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
          wasistlos
        ];
      };
    };
  };
}
