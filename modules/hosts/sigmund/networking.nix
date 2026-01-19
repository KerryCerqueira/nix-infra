{
  flake.nixosModules.sigmund = {
    networking.hostName = "sigmund";
    networking.networkmanager.enable = true;
  };
}
