{
  flake.nixosModules.napoleon = {...}: {
    services.fstrim.enable = true;
    fileSystems = {
      "/" = {
        label = "npln-root";
        fsType = "ext4";
      };
      "/home" = {
        label = "npln-home";
        fsType = "ext4";
      };
      "/boot" = {
        label = "NPLN-BOOT";
        fsType = "vfat";
        options = ["fmask=0077" "dmask=0077"];
      };
      "/nix" = {
        label = "npln-nix";
        fsType = "ext4";
      };
      "/mnt/extra" = {
        label = "extra";
        fsType = "ext4";
      };
    };
    swapDevices = [
      {label = "npln-swap";}
    ];
  };
}
