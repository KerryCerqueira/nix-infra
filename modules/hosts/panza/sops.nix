{
  flake.nixosModules.panza = {
    sops = {
      defaultSopsFile = ./secrets.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = "/etc/age/panza.age";
      secrets = {
        "hashedUserPasswords/kerry".neededForUsers = true;
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
