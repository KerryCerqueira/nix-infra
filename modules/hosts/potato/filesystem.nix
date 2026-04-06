{...}: {
  flake.nixosModules.potato = {...}: {
    fileSystems = {
      "/" = {
        device = "/dev/disk/by-uuid/52e55dc0-fd62-4463-aae6-315692666a33";
        fsType = "ext4";
      };
      "/boot" = {
        device = "/dev/disk/by-uuid/3874-7438";
        fsType = "vfat";
        options = ["fmask=0022" "dmask=0022"];
      };
      "/home" = {
        device = "/dev/disk/by-uuid/487d2b26-15d3-42b8-95b4-ccb27e24eec8";
        fsType = "ext4";
      };
      "/nix" = {
        device = "/dev/disk/by-uuid/ccec961c-815e-4d16-84ed-f0c9aa067675";
        fsType = "ext4";
      };
    };
    swapDevices = [
      {device = "/dev/disk/by-uuid/a8db59dd-fc25-45af-b4a1-ff257158f600";}
    ];
  };
}
