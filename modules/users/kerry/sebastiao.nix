{self, ...}: {
  flake = {
    nixosModules.sebastiao = {config, ...}: {
      imports = [self.nixosModules.kerry];
      users.users.kerry.hashedPasswordFile =
        config.sops.secrets."kerry/hashedPassword".path;
      sops.secrets = {
        "kerry/hashedPassword".neededForUsers = true;
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
