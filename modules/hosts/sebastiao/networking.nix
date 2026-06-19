{
  flake.nixosModules.sebastiao = {lib, ...}: {
    networking = {
      hostName = "sebastiao";
      networkmanager.enable = true;
    };
  };
}
