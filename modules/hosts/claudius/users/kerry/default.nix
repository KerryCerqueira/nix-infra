{self, ...}: {
  flake.nixosModules.claudius = {
    users.users.kerry = {
      isNormalUser = true;
      description = "Kerry Cerqueira";
      extraGroups = ["networkmanager" "wheel"];
    };
    home-manager.users.kerry = {
      imports = [
        self.homeModules."kerry@claudius"
      ];
    };
  };
  flake.homeModules."kerry@claudius" = {
    home.stateVersion = "24.11";
  };
}
