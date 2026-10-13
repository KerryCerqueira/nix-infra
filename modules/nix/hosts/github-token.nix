{lib, ...}: {
  flake.nixosModules =
    lib.genAttrs [
      "claudius"
      "panza"
      "sebastiao"
      "napoleon"
    ] (host: {config, ...}: {
      sops = {
        secrets.github-token = {
          sopsFile = ./secrets/${host}/github-token;
          format = "binary";
        };
        templates.nix-github-token = {
          content = ''
            extra-access-tokens = github.com=${config.sops.placeholder.github-token}
          '';
          restartUnits = ["nix-daemon.service"];
        };
      };
      nix.extraOptions = ''
        !include ${config.sops.templates.nix-github-token.path}
      '';
    });
}
