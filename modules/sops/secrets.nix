{lib, ...}: {
  flake.nixosModules =
    lib.genAttrs [
      "claudius"
      "panza"
      "sebastiao"
    ] (host: {config, ...}: {
      sops.secrets.ageKey = {
        sopsFile = ./secrets/${host}/keys.txt;
        format = "binary";
        owner = "kerry";
        mode = "0400";
      };
      home-manager.users.kerry.home.sessionVariables.SOPS_AGE_KEY_FILE =
        config.sops.secrets.ageKey.path;
    });
}
