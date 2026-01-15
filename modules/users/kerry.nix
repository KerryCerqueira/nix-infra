{
  self,
  inputs,
  ...
}: {
  flake = {
    homeConfigurations."kcerqueira@cruncher" = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {system = "x86_64-linux";};
      modules = [
        {
          programs.home-manager.enable = true;
          nixpkgs.config.allowUnfree = true;
          home = {
            stateVersion = "25.05";
            username = "kcerqueira";
            homeDirectory = "/home/kcerqueira";
          };
          nix = {
            package = inputs.nixpkgs.legacyPackages.x86_64-linux.nix;
            settings.experimental-features = [
              "nix-command"
              "flakes"
              "pipe-operators"
            ];
          };
        }
        self.homeModules.nvim
        self.homeModules.shell
      ];
    };
    homeModules = {
      "kerry@muncher" = {
        imports = with self.homeModules; [
          nvim
          terminal
        ];
        nixpkgs.config.allowUnfree = true;
        programs.home-manager.enable = true;
        home = {
          stateVersion = "25.11";
          username = "kerry";
          homeDirectory = "/home/kerry";
        };
      };
      kerry = {pkgs, ...}: {
        imports = with self.homeModules; [
          libreoffice
          zathura
          keepassxc
          nvim
          terminal
          ssh
          syncthing
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
  };
}
