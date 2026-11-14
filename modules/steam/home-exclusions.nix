{lib, ...}: {
  flake.nixosModules = lib.mkMerge [
    (
      lib.genAttrs
      [
        "kerry-claudius"
        "kerry-panza"
      ]
      (_: {config, ...}: let
        kerry = config.users.users.kerry;
      in {
        systemd.tmpfiles.settings."home-snapshots" = {
          "${kerry.home}/.local/share/Steam/steamapps".v = {
            user = kerry.name;
            group = kerry.group;
            mode = "0700";
          };
        };
      })
    )
    (
      lib.genAttrs
      ["erika-panza"]
      (_: {config, ...}: let
        erika = config.users.users.erika;
      in {
        systemd.tmpfiles.settings."home-snapshots" = {
          "${erika.home}/.local/share/Steam/steamapps".v = {
            user = erika.name;
            group = erika.group;
            mode = "0700";
          };
        };
      })
    )
    (
      lib.genAttrs
      [
        "jovianUser"
      ]
      (_: {config, ...}: let
        steam = config.users.users.steam;
      in {
        systemd.tmpfiles.settings."home-snapshots" = {
          "${steam.home}/.local/share/Steam/steamapps".v = {
            user = steam.name;
            group = steam.group;
            mode = "0700";
          };
        };
      })
    )
  ];
}
