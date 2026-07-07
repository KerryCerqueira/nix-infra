{self, ...}: {
  flake.nixosModules.napoleon = {config, ...}: {
    imports = [self.nixosModules.kerry];
    users.users.kerry = {
      extraGroups = ["extra-store"];
      hashedPasswordFile = config.sops.secrets."kerry/hashedPassword".path;
      uid = 1000;
    };
    sops.secrets."kerry/hashedPassword".neededForUsers = true;
    home-manager.users.kerry = self.homeModules."kerry@napoleon";
  };
  flake.homeModules."kerry@napoleon" = {imports = [self.homeModules.kerry];};
}
