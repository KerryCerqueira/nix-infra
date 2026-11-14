{
  flake.nixosModules.erika-panza = {config, ...}: let
    erika = config.users.users.erika;
  in {
    disko.devices.disk.panza-nvme = {
      content.partitions.root.content.content.subvolumes."@erika" = {
        mountpoint = "/home/erika";
        mountOptions = ["compress=zstd" "noatime"];
      };
    };
    systemd.tmpfiles.settings."home-snapshots" = {
      "${erika.home}/.cache".v = {
        user = erika.name;
        group = erika.group;
        mode = "0700";
      };
      "${erika.home}/.snapshots".v = {
        user = "root";
        group = "root";
        mode = "0750";
      };
    };
    services.snapper.configs.erika-home = {
      SUBVOLUME = erika.home;
      ALLOW_USERS = [erika.name];
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
