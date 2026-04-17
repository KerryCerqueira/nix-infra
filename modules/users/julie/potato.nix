{self, ...}: {
  flake.nixosModules.potato = {...}: {
    users.users.julie = {
      isNormalUser = true;
      uid = self.lib.constants.uids.julie;
      description = "Julie Quigley";
      extraGroups = ["networkmanager"];
    };
    home-manager.users.julie = self.homeModules."julie@potato";
  };
  flake.homeModules."julie@potato" = {...}: {
    home.stateVersion = "23.11";
  };
}
