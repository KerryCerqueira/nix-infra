{...}: {
  flake.homeModules."kerry@napoleon" = {
    config,
    pkgs,
    ...
  }: {
    sops = {
      defaultSopsFile = ./secrets.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = "/home/kerry/.config/sops/age/keys.txt";
      secrets = {
        "syncthing/cert" = {
          path = "${config.home.homeDirectory}/.config/syncthing/cert.pem";
        };
        "syncthing/key" = {
          path = "${config.home.homeDirectory}/.config/syncthing/key.pem";
        };
        "apiKeys/tavily" = {};
        "apiKeys/huggingface" = {};
      };
    };
  };
}
