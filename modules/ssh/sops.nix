{lib, ...}: {
  flake.nixosModules =
    lib.genAttrs [
      "claudius"
      "mushu"
      "panza"
      "sebastiao"
    ] (host: {
      sops.secrets."ssh/kerry_ed25519" = {
        sopsFile = ./secrets + "/${host}/kerry_ed25519";
        format = "binary";
        owner = "kerry";
        mode = "0400";
      };
    });
  flake.homeModules =
    lib.genAttrs [
      "kerry-claudius"
      "kerry-mushu"
      "kerry-panza"
      "kerry-sebastiao"
    ] (_: {
      config,
      osConfig,
      ...
    }: {
      programs.ssh.settings."*".identityFile =
        osConfig.sops.secrets."ssh/kerry_ed25519".path;
    });
}
