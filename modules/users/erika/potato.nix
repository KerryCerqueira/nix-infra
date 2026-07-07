{self, ...}: {
  flake.nixosModules.potato = {...}: {
    users.users.erika = {
      isNormalUser = true;
      description = "Erika";
      extraGroups = ["networkmanager" "wheel"];
    };
    home-manager.users.erika = self.homeModules."erika@potato";
  };
  flake.homeModules."erika@potato" = {
    imports = [self.homeModules.erika];
  };
}
