{self, ...}: {
  flake = {
    nixosModules = {
      ssh = {...}: {
        programs.ssh.knownHosts = {
          claudius = {
            hostNames = ["claudius"];
            publicKey =
              builtins.readFile ./public-keys/claudius/root_ed25519.pub;
          };
          sebastiao = {
            hostNames = ["sebastiao"];
            publicKey =
              builtins.readFile ./public-keys/sebastiao/root_ed25519.pub;
          };
          napoleon = {
            hostNames = ["napoleon"];
            publicKey =
              builtins.readFile ./public-keys/napoleon/root_ed25519.pub;
          };
        };
      };
      claudius.imports = [self.nixosModules.ssh];
      sebastiao.imports = [self.nixosModules.ssh];
      panza.imports = [self.nixosModules.ssh];
      potato.imports = [self.nixosModules.ssh];
      napoleon.imports = [self.nixosModules.ssh];
    };
    homeModules = {
      ssh = {...}: {
        programs.ssh = {
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
      kerry.imports = [self.homeModules.ssh];
    };
  };
}
