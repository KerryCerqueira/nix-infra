{...}: {
  flake.homeModules.syncthing = {config, ...}: {
    services = {
      syncthing = {
        enable = true;
        tray.enable = true;
        tray.command = "syncthingtray --wait";
      };
    };
  };
}
