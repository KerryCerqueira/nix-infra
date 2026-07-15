{self, ...}: {
  flake = {
    nixosModules.panza = {config, ...}: {
      imports = [self.nixosModules.kerry];
      home-manager.users.kerry = self.homeModules."kerry@panza";
    };
    homeModules."kerry@panza" = {imports = [self.homeModules.kerry];};
  };
}
