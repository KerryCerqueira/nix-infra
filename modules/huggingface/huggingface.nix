{lib, ...}: {
  flake.nixosModules =
    lib.genAttrs [
      "claudius"
      "sebastiao"
    ] (host: {config, ...}: {
      sops.secrets.hfToken = {
        sopsFile = ./secrets/${host}/token;
        format = "binary";
        owner = "kerry";
        mode = "0400";
      };
      home-manager.users.kerry.home.sessionVariables = {
        HF_TOKEN_PATH = config.sops.secrets.hfToken.path;
        HF_HUB_DISABLE_IMPLICIT_TOKEN = "1";
      };
    });
}
