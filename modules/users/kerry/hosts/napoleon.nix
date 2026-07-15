{self, ...}: {
  flake.nixosModules.napoleon = {config, ...}: {
    imports = [self.nixosModules.kerry];
    users.users.kerry = {
      uid = self.lib.constants.uids.kerry;
    };
    home-manager.users.kerry = self.homeModules."kerry@napoleon";
  };
  flake.homeModules."kerry@napoleon" = {imports = [self.homeModules.kerry];};
}
