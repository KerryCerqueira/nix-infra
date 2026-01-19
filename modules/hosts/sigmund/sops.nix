{
  flake.nixosModules.sigmund = {
    sops = {
      defaultSopsFile = ./secrets.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = "/etc/age/sigmund.age";
      secrets = {
        "ageKeys/kerrySigmund" = {
          path = "/home/kerry/.config/sops/age/kerry_sigmund.age";
          owner = "kerry";
        };
      };
    };
  };
}
