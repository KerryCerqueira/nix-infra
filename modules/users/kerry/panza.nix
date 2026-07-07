{self, ...}: {
  flake = {
    nixosModules.panza = {config, ...}: {
      imports = [self.nixosModules.kerry];
      sops.secrets."kerry/hashedPassword".neededForUsers = true;
      users.users.kerry.hashedPasswordFile =
        config.sops.secrets."kerry/hashedPassword".path;
      home-manager.users.kerry = self.homeModules."kerry@panza";
    };
    homeModules."kerry@panza" = {imports = [self.homeModules.kerry];};
  };
}
