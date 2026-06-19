{inputs, ...}: {
  flake.nixosModules.sebastiao = {...}: {
    imports = [inputs.sops-nix.nixosModules.sops];
    sops = {
      defaultSopsFile = ./secrets.yaml;
      defaultSopsFormat = "yaml";
      age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
      secrets = {
        "ageKeys/kerryMaster" = {
          path = "/home/kerry/.config/sops/age/keys.txt";
          owner = "kerry";
        };
        "ageKeys/kerrySebastiao" = {
          path = "/home/kerry/.config/sops/age/kerry_sebastiao.age";
          owner = "kerry";
        };
        "hashedUserPasswords/kerry".neededForUsers = true;
        "hashedUserPasswords/root".neededForUsers = true;
      };
    };
  };
}
