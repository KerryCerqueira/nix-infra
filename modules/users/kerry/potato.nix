{self, ...}: {
  flake.nixosModules.potato = {...}: {
    imports = [self.nixosModules.kerry];
    home-manager.users.kerry = self.homeModules."kerry@potato";
  };
  flake.homeModules."kerry@potato" = {imports = [self.homeModules.kerry];};
}
