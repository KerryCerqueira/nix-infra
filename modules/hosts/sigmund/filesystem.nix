{
  flake.nixosModules.sigmund = {
    fileSystems."/" = {
      device = "/dev/disk/by-uuid/7ddd4ab6-5880-4e10-b05c-74277169e995";
      fsType = "ext4";
    };
    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/CB48-A88B";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };
    fileSystems."/home" = {
      device = "/dev/disk/by-uuid/215ff276-11b3-4009-ac3d-f24b7227e115";
      fsType = "ext4";
    };
    fileSystems."/nix/store" = {
      device = "/dev/disk/by-uuid/ddaa21cb-8280-4bbf-ac45-5572ba2f69ba";
      fsType = "ext4";
    };
    swapDevices = [
      {device = "/dev/disk/by-uuid/9e3ab993-c400-46f5-8810-2089c5edf763";}
    ];
  };
}
