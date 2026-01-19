{self, ...}: {
  flake.nixosModules.sigmund = {
    users.users.kerry = {
      isNormalUser = true;
      description = "Kerry Cerqueira";
      extraGroups = ["networkmanager" "wheel"];
    };
    home-manager.users.kerry = self.homeModules."kerry@sigmund";
  };
  flake.homeModules."kerry@sigmund" = {
    imports = with self.homeModules; [
      kerry
    ];
    home.stateVersion = "24.11";
  };
}
