{
  flake.nixosModules.panza = {lib, ...}: {
    networking = {
      hostName = "panza";
      networkmanager.enable = true;
    };
  };
}
