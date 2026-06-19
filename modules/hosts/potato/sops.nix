{inputs, ...}: {
  flake.nixosModules.potato = {...}: {
    imports = [inputs.sops-nix.nixosModules.sops];
    sops = {
      defaultSopsFile = ./secrets.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = "/etc/age/potato.age";
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
