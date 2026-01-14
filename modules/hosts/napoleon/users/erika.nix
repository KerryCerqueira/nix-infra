{self, ...}: {
  flake.nixosModules.napoleon = {
    users.users.erika = {
      isNormalUser = true;
      description = "Erika Titley";
      extraGroups = ["networkmanager" "wheel"];
    };
    home-manager.users.erika = {
      imports = [
        self.homeModules."erika@napoleon"
      ];
    };
  };
  flake.homeModules."erika@napoleon" = {
    config,
    pkgs,
    ...
  }: {
    imports = [
      self.homeModules.erika
    ];
    home.stateVersion = "25.11";
  };
}
