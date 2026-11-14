{
  flake.nixosModules.jovianUser = {config, ...}: let
    steam = config.users.users.steam;
  in {
    disko.devices.disk.napoleon-os = {
      content.partitions.root.content.content.subvolumes."@steam" = {
        mountpoint = "/home/steam";
        mountOptions = ["compress=zstd" "noatime"];
      };
    };
    systemd.tmpfiles.settings."home-snapshots" = {
      "${steam.home}/.cache".v = {
        user = steam.name;
        group = steam.group;
        mode = "0700";
      };
      "${steam.home}/.snapshots".v = {
        user = "root";
        group = "root";
        mode = "0750";
      };
    };
    services.snapper.configs.steam-home = {
      SUBVOLUME = steam.home;
      ALLOW_USERS = [steam.name];
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
}
