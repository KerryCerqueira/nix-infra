{...}: {
  flake.homeModules.syncthing = {config, ...}: {
    services = {
      syncthing = {
        enable = true;
        tray.enable = true;
        tray.command = "syncthingtray --wait";
        overrideDevices = false;
        overrideFolders = false;
        settings.devices."pixel7a".id =
          "TFIHFTM-GZAXN5C-KEKCVVS-56GOS33-ZTMUZWC-QMMVYUE-XKHQQUL-3E5FOAS";
      };
    };
  };
}
