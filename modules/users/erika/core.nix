{self, ...}: {
  flake = {
    nixosModules = {
      erika = {
        users.users.erika = {
          isNormalUser = true;
          description = "Erika Titley";
          extraGroups = ["networkmanager" "wheel"];
        };
      };
      mushu = {
        imports = [self.nixosModules.erika];
        home-manager.users.erika = self.homeModules."erika@mushu";
      };
      panza = {
        imports = [self.nixosModules.erika];
        home-manager.users.erika = self.homeModules."erika@panza";
      };
      potato = {
        imports = [self.nixosModules.erika];
        home-manager.users.erika = self.homeModules."erika@potato";
      };
    };
    homeModules = {
      erika = {pkgs, ...}: {
        programs = {
          home-manager.enable = true;
          chromium.enable = true;
          thunderbird.enable = true;
        };
        home = {
          packages = with pkgs; [
            discord
            zoom-us
            rnote
            vlc
            spotify
            karere
            zotero
          ];
        };
      };
      "erika@mushu".imports = [self.homeModules.erika];
      "erika@panza".imports = [self.homeModules.erika];
      "erika@potato".imports = [self.homeModules.erika];
    };
  };
}
