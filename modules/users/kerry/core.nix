{self, ...}: {
  flake = {
    homeModules = {
      "kerry@muncher" = {
        imports = with self.homeModules; [
          neovim
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
          neovim
          terminal
          ssh
          syncthing
        ];
        programs = {
          home-manager.enable = true;
          thunderbird.enable = true;
          chromium.enable = true;
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
