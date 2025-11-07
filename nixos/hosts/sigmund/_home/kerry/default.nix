{...}: {
  home.stateVersion = "24.11";
  sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/kerry/.config/sops/age/kerry_sigmund.age";
    secrets = {
      "ssh/identity/public" = {
        path = "/home/kerry/.ssh/id_ed25519.pub";
      };
      "ssh/identity/private" = {
        path = "/home/kerry/.ssh/id_ed25519";
      };
    };
  };
}
