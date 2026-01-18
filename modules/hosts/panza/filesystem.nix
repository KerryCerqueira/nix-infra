{
  flake.nixosModules.panza = {
    fileSystems = {
      "/" = {
        device = "/dev/disk/by-uuid/5fc03019-c6c8-4d7e-9056-32f9c318c1b6";
        fsType = "ext4";
      };
      "/boot" = {
        device = "/dev/disk/by-uuid/AC23-4599";
        fsType = "vfat";
        options = ["fmask=0022" "dmask=0022"];
      };
      "/home" = {
        device = "/dev/disk/by-uuid/c67ed632-d694-454d-b39e-95322d23d0a5";
        fsType = "ext4";
      };
      "/nix" = {
        device = "/dev/disk/by-uuid/449f9f98-da15-4965-8311-c0ce7a803211";
        fsType = "ext4";
      };
    };
    swapDevices = [
      {device = "/dev/disk/by-uuid/048cb61f-0fa8-4960-8607-97aa670662cf";}
    ];
  };
}
