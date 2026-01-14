{
  flake.nixosModules.claudius = {...}: {
    sops = {
      defaultSopsFile = ./secrets.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = let
        envKey = builtins.getEnv "SOPS_AGE_KEY_FILE";
      in
        if envKey == ""
        then "/etc/age/claudius.age"
        else envKey;
      secrets = {
        "ageKeys/kerryMaster" = {
          path = "/home/kerry/.config/sops/age/kerry_master.age";
          owner = "kerry";
        };
        "ageKeys/kerryPotato" = {
          path = "/home/kerry/.config/sops/age/kerry_potato.age";
          owner = "kerry";
        };
        "ageKeys/kerryLazarus" = {
          path = "/home/kerry/.config/sops/age/kerry_lazarus.age";
          owner = "kerry";
        };
        "ageKeys/kerryClaudius" = {
          path = "/home/kerry/.config/sops/age/kerry_claudius.age";
          owner = "kerry";
        };
      };
    };
  };
}
