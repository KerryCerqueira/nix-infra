{self, ...}: {
  flake = {
    nixosModules = {
      ssh = {...}: {
        programs.ssh.knownHosts = {
          claudius = {
            hostNames = ["claudius"];
            publicKey = self.lib.constants.publicKeys."root@claudius";
          };
          sebastiao = {
            hostNames = ["sebastiao"];
            publicKey = self.lib.constants.publicKeys."root@sebastiao";
          };
          napoleon = {
            hostNames = ["napoleon"];
            publicKey = self.lib.constants.publicKeys."root@napoleon";
          };
        };
      };
      claudius = {imports = [self.nixosModules.ssh];};
      sebastiao = {imports = [self.nixosModules.ssh];};
      panza = {imports = [self.nixosModules.ssh];};
      potato = {imports = [self.nixosModules.ssh];};
      napoleon = {imports = [self.nixosModules.ssh];};
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
              identityFile = "~/.ssh/id_ed25519";
              addKeysToAgent = "yes";
            };
            "github" = {
              hostname = "github.com";
              user = "git";
            };
          };
        };
      };
      kerry = {imports = [self.homeModules.ssh];};
      "kerry@claudius" = {config, ...}: {
        sops.secrets."ssh".path =
          "${config.home.homeDirectory}"
          + "/.ssh/id_ed25519";
        home.file = {
          ".ssh/id_ed25519.pub".source = ./public-keys/kerry_claudius.pub;
        };
        programs.ssh.settings."*".identityFile = "~/.ssh/id_ed25519";
      };
      "kerry@napoleon" = {config, ...}: {
        sops.secrets."ssh".path =
          "${config.home.homeDirectory}"
          + "/.ssh/id_ed25519";
        home.file = {
          ".ssh/id_ed25519.pub".source = ./public-keys/kerry_napoleon.pub;
        };
        programs.ssh.settings."*".identityFile = "~/.ssh/id_ed25519";
      };
      "kerry@potato" = {config, ...}: {
        sops.secrets."ssh".path =
          "${config.home.homeDirectory}"
          + "/.ssh/id_ed25519";
        home.file = {
          ".ssh/id_ed25519.pub".source = ./public-keys/kerry_potato.pub;
        };
        programs.ssh.settings."*".identityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}
