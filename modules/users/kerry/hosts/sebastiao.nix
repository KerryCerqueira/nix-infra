{
  flake = {
    nixosModules.sebastiao = {config, ...}: {
      sops.secrets = {
        "kerry/ageKeys" = {
          path = "${config.users.users.kerry.home}/.config/sops/age/keys.txt";
          owner = "kerry";
          mode = "0400";
        };
      };
    };
  };
}
