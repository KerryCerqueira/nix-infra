{
  flake.nixosModules.claudius = {...}: {
    fileSystems."/" = {
      device = "/dev/disk/by-uuid/d0057b39-6872-46bf-80dd-9bef299c34d2";
      fsType = "ext4";
    };
    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/E0C6-AD7A";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };
    fileSystems."/home" = {
      device = "/dev/disk/by-uuid/095b8da7-50ab-4734-92bc-6d12cb050262";
      fsType = "ext4";
    };
    fileSystems."/nix/store" = {
      device = "/dev/disk/by-uuid/7019e775-36b6-4d8a-8fcf-cfb1febc0fc5";
      fsType = "ext4";
    };
    swapDevices = [
      {device = "/dev/disk/by-uuid/5f2d7fc1-10ad-4be8-9f19-5f59426267b7";}
    ];
  };
}
