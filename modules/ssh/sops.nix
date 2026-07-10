{lib, ...}: {
  flake.nixosModules =
    lib.genAttrs [
      "claudius"
      "napoleon"
      "panza"
      "potato"
      "sebastiao"
    ] (host: {config, ...}: {
      sops.secrets."ssh/kerry_ed25519" = {
        sopsFile = ./secrets + "/${host}/kerry_ed25519";
        format = "binary";
        owner = "kerry";
        mode = "0400";
        path = "${config.users.users.kerry.home}/.ssh/id_ed25519";
      };
    });
  flake.homeModules =
    lib.genAttrs [
      "kerry@claudius"
      "kerry@napoleon"
      "kerry@panza"
      "kerry@potato"
      "kerry@sebastiao"
    ] (_: {
      config,
      osConfig,
      ...
    }: {
      home.file.".ssh/id_ed25519.pub".source =
        ./public-keys
        + "/${osConfig.networking.hostName}"
        + "/${config.home.username}_ed25519.pub";
      programs.ssh.settings."*".identityFile =
        osConfig.sops.secrets."ssh/kerry_ed25519".path;
    });
}
