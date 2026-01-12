{config, ...}: {
  home.stateVersion = "23.11";
  sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/kerry.age";
    secrets = {
      "syncthing/cert" = {
        path = "${config.home.homeDirectory}/.config/syncthing/cert.pem";
      };
      "syncthing/key" = {
        path = "${config.home.homeDirectory}/.config/syncthing/key.pem";
      };
    };
  };
}
