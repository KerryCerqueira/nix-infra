{
  flake.homeModules."kerry@sigmund" = {config, ...}: {
    sops = {
      secrets = {
        "syncthing/cert" = {
          path = "${config.home.homeDirectory}/.config/syncthing/cert.pem";
        };
        "syncthing/key" = {
          path = "${config.home.homeDirectory}/.config/syncthing/key.pem";
        };
      };
    };
  };
}
