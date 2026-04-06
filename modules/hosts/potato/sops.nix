{...}: {
  flake.nixosModules.potato = {...}: {
    sops = {
      defaultSopsFile = ./secrets.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = let
        envKey = builtins.getEnv "SOPS_AGE_KEY_FILE";
      in
        if envKey == ""
        then "/etc/age/potato.age"
        else envKey;
      secrets = {
        "ageKeys/kerryPotato" = {
          path = "/home/kerry/.config/sops/age/kerry_potato.age";
          owner = "kerry";
        };
        "ageKeys/erikaMaster" = {
          path = "/home/erika/.config/sops/age/erika_master.age";
          owner = "erika";
        };
      };
    };
  };
}
