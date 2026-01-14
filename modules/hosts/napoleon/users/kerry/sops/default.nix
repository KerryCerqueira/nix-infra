{...}: {
  flake.homeModules."kerry@napoleon" = {
    config,
    pkgs,
    ...
  }: {
    sops = {
      defaultSopsFile = ./secrets.yaml;
      defaultSopsFormat = "yaml";
      age.sshKeyPaths = [
        "${config.home.homeDirectory}/.ssh/id_ed25519"
      ];
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
