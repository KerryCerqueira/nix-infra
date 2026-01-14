{...}: {
  flake.nixosModules.napoleon = {
    config,
    pkgs,
    ...
  }: {
    sops = {
      defaultSopsFile = ./secrets.yaml;
      defaultSopsFormat = "yaml";
      age.sshKeyPaths = [
        "/etc/ssh/ssh_host_ed25519_key"
      ];
      secrets = {
        "ageKeys/kerryNapoleon" = {
          path = "/home/kerry/.config/sops/age/keys.txt";
          owner = "kerry";
        };
        "sshKeys/kerry/public" = {
          path = "/home/kerry/.ssh/id_ed25519.pub";
          owner = "kerry";
        };
        "sshKeys/kerry/private" = {
          path = "/home/kerry/.ssh/id_ed25519";
          owner = "kerry";
        };
        "hashedUserPasswords/kerry".neededForUsers = true;
        "hashedUserPasswords/erika".neededForUsers = true;
        "hashedUserPasswords/root".neededForUsers = true;
      };
    };
  };
}
