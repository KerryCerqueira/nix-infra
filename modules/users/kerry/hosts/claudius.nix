{
  flake.nixosModules.kerry-claudius = {config, ...}: let
    kerry = config.users.users.kerry;
  in {
    disko.devices.disk.claudius-nvme = {
      content.partitions.root.content.content.subvolumes."@kerry" = {
        mountpoint = "/home/kerry";
        mountOptions = ["compress=zstd" "noatime"];
      };
    };
    sops.secrets."kerry/ageKeys" = {
      path = "${kerry.home}/.config/sops/age/keys.txt";
      owner = "kerry";
      mode = "0400";
    };
    systemd.tmpfiles.settings."home-snapshots" = {
      "${kerry.home}/.cache".v = {
        user = kerry.name;
        group = kerry.group;
        mode = "0700";
      };
      "${kerry.home}/.snapshots".v = {
        user = "root";
        group = "root";
        mode = "0750";
      };
    };
    services.snapper.configs.kerry-home = {
      SUBVOLUME = kerry.home;
      ALLOW_USERS = [kerry.name];
      SYNC_ACL = true;
      TIMELINE_CREATE = true;
      TIMELINE_CLEANUP = true;
      TIMELINE_LIMIT_HOURLY = 24;
      TIMELINE_LIMIT_DAILY = 7;
      TIMELINE_LIMIT_WEEKLY = 4;
      TIMELINE_LIMIT_MONTHLY = 6;
      TIMELINE_LIMIT_QUARTERLY = 0;
      TIMELINE_LIMIT_YEARLY = 0;
      NUMBER_CLEANUP = true;
      NUMBER_LIMIT = 20;
      NUMBER_LIMIT_IMPORTANT = 10;
    };
  };
  deployments.nixosModules.kerry-claudius = ["claudius"];
}
