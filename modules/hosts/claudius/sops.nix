{inputs, ...}: {
  flake.nixosModules.claudius = {...}: {
    imports = [inputs.sops-nix.nixosModules.sops];
    sops = {
      defaultSopsFile = ./secrets.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = "/etc/age/claudius.age";
      secrets = {
        "ageKeys/kerryMaster" = {
          path = "/home/kerry/.config/sops/age/keys.txt";
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
