{
  flake.nixosModules.napoleon = {...}: {
    services.fstrim.enable = true;
    fileSystems = {
      "/" = {
        label = "napoleon-root";
        fsType = "ext4";
      };
      "/home" = {
        label = "napoleon-home";
        fsType = "ext4";
      };
      "/boot" = {
        label = "napoleon-boot";
        fsType = "vfat";
        options = ["fmask=0077" "dmask=0077"];
      };
      "/nix" = {
        label = "napoleon-nix";
        fsType = "ext4";
      };
    };
    swapDevices = [
      {label = "napoleon-swap";}
    ];
  };
}
