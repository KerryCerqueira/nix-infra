{self, ...}: {
  flake = {
    nixosModules.claudius = {config, ...}: {
      imports = [self.nixosModules.kerry];
      home-manager.users.kerry = self.homeModules."kerry@claudius";
      sops.secrets = {
        "kerry/ageKeys" = {
          path = "/home/kerry/.config/sops/age/keys.txt";
          owner = "kerry";
          mode = "0400";
        };
      };
    };
    homeModules."kerry@claudius" = {imports = [self.homeModules.kerry];};
  };
}
