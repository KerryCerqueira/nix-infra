{self, ...}: {
  flake = {
    nixosModules = {
      julie = {
        users.users.julie = {
          isNormalUser = true;
          description = "Julie Quigley";
          extraGroups = ["networkmanager"];
        };
      };
      mushu = {
        imports = [self.nixosModules.julie];
        home-manager.users.julie = self.homeModules."julie@mushu";
      };
    };
    homeModules = {
      julie = {pkgs, ...}: {
        programs = {
          home-manager.enable = true;
          chromium.enable = true;
          firefox.enable = true;
          thunderbird.enable = true;
        };
        home = {
          packages = with pkgs; [
            discord
            zoom-us
            rnote
            vlc
            spotify
          ];
        };
      };
      "julie@mushu".imports = [self.homeModules.julie];
    };
  };
}
