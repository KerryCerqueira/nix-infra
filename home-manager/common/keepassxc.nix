{...}: {
  flake.homeModules.keepassxc = {config, ...}: {
    programs.keepassxc = {
      enable = true;
    };
    services.syncthing.settings.folders."keepassxc" = {
      devices = [ "pixel7a" ];
      id = "keepassxc";
      label = "keepassxc";
      path = "${config.home.homeDirectory}/.local/share/keepassxc";
      versioning = {
        type = "trashcan";
        params.cleanoutDays = "1000";
      };
    };
  };
}
