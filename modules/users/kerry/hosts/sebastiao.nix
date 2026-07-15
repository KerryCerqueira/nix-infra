{self, ...}: {
  flake = {
    nixosModules.sebastiao = {config, ...}: {
      imports = [self.nixosModules.kerry];
      sops.secrets = {
        "kerry/ageKeys" = {
          path = "${config.users.users.kerry.home}/.config/sops/age/keys.txt";
          owner = "kerry";
          mode = "0400";
        };
      };
      home-manager.users.kerry = self.homeModules."kerry@sebastiao";
    };
    homeModules."kerry@sebastiao" = {imports = [self.homeModules.kerry];};
  };
}
