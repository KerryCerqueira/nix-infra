{lib, ...}: {
  flake = {
    nixosModules.ssh.programs.ssh.knownHosts =
      lib.genAttrs [
        "claudius"
        "mushu"
        "sebastiao"
        "napoleon"
      ] (host: {
        hostNames = [host];
        publicKey =
          builtins.readFile (./public-keys + "/${host}/root_ed25519.pub");
      });
    homeModules.ssh.programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      includes = ["~/.ssh/config.d/*.conf"];
      settings = {
        "*" = {
          controlMaster = "auto";
          controlPersist = "10m";
          identitiesOnly = true;
          serverAliveInterval = 15;
          serverAliveCountMax = 3;
          controlPath = "~/.ssh/master-%r@%n:%p";
          addKeysToAgent = "yes";
        };
        "github" = {
          hostname = "github.com";
          user = "git";
        };
      };
    };
  };
  deployments = {
    nixosModules.ssh = [
      "claudius"
      "sebastiao"
      "panza"
      "napoleon"
    ];
    homeModules.ssh = ["kerry"];
  };
}
