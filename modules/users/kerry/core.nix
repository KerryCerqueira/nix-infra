{self, ...}: {
  flake = {
    nixosModules = {
      kerry = {config, ...}: {
        users.users.kerry = {
          isNormalUser = true;
          description = "Kerry Cerqueira";
          extraGroups = ["networkmanager" "wheel"];
          hashedPasswordFile =
            config.sops.secrets."hashedPasswords/kerry".path;
        };
        sops.secrets."hashedPasswords/kerry" = {
          sopsFile = ./secrets/hashed-password;
          format = "binary";
          neededForUsers = true;
        };
      };
      claudius = {
        imports = [self.nixosModules.kerry];
        home-manager.users.kerry = self.homeModules."kerry@claudius";
      };
      mushu = {
        imports = [self.nixosModules.kerry];
        home-manager.users.kerry = self.homeModules."kerry@mushu";
      };
      panza = {
        imports = [self.nixosModules.kerry];
        home-manager.users.kerry = self.homeModules."kerry@panza";
      };
      potato = {
        imports = [self.nixosModules.kerry];
        home-manager.users.kerry = self.homeModules."kerry@potato";
      };
      sebastiao = {
        imports = [self.nixosModules.kerry];
        home-manager.users.kerry = self.homeModules."kerry@sebastiao";
      };
    };
    homeModules = {
      kerry = {pkgs, ...}: {
        programs = {
          home-manager.enable = true;
          thunderbird.enable = true;
          chromium.enable = true;
        };
        home.packages = with pkgs; [
          claude-code
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
          karere
        ];
      };
      "kerry@claudius".imports = [self.homeModules.kerry];
      "kerry@mushu".imports = [self.homeModules.kerry];
      "kerry@panza".imports = [self.homeModules.kerry];
      "kerry@potato".imports = [self.homeModules.kerry];
      "kerry@sebastiao".imports = [self.homeModules.kerry];
    };
  };
}
