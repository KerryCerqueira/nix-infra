{self, ...}: {
  flake = {
    nixosModules.napoleon = {
      users.users.erika = {
        isNormalUser = true;
        description = "Erika Titley";
        extraGroups = ["networkmanager" "wheel" "extra-store"];
        uid = 1001;
      };
      home-manager.users.erika = {
        imports = [self.homeModules."erika@napoleon"];
      };
    };
    homeModules."erika@napoleon" = {imports = [self.homeModules.erika];};
  };
}
