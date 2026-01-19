{
  flake.nixosModules.sigmund = {
    users.users.kerry = {
      isNormalUser = true;
      description = "Kerry Cerqueira";
      extraGroups = ["networkmanager" "wheel"];
    };
  };
  flake.nixosModules."kerry@sigmund" = {
    home.stateVersion = "24.11";
  };
}
