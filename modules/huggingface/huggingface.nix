{lib, ...}: {
  flake.nixosModules =
    lib.genAttrs [
      "claudius"
      "napoleon"
      "sebastiao"
    ] (host: {config, ...}: let
      kerry = config.users.users.kerry;
    in {
      sops.secrets.hfToken = {
        path = "${kerry.home}/.cache/huggingface/token";
        sopsFile = ./secrets/${host}/token;
        format = "binary";
        owner = "kerry";
        mode = "0400";
      };
    });
}
