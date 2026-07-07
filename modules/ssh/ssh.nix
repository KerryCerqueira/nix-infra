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
      claudius = {
        imports = [self.nixosModules.ssh];
        sops.secrets."kerry/ssh" = {
          owner = "kerry";
          mode = "0400";
        };
      };
      sebastiao = {
        imports = [self.nixosModules.ssh];
        sops.secrets."kerry/ssh" = {
          owner = "kerry";
          mode = "0400";
        };
      };
      panza = {
        imports = [self.nixosModules.ssh];
        sops.secrets."kerry/ssh" = {
          owner = "kerry";
          mode = "0400";
        };
      };
      potato = {
        imports = [self.nixosModules.ssh];
        sops.secrets."kerry/ssh" = {
          owner = "kerry";
          mode = "0400";
        };
      };
      napoleon = {
        imports = [self.nixosModules.ssh];
        sops.secrets."kerry/ssh" = {
          owner = "kerry";
          mode = "0400";
        };
      };
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
      kerry = {imports = [self.homeModules.ssh];};
      "kerry@claudius" = {osConfig, ...}: {
        home.file = {
          ".ssh/id_ed25519.pub".source = ./public-keys/kerry_claudius.pub;
        };
        programs.ssh.settings."*".identityFile = osConfig.sops.secrets."kerry/ssh".path;
      };
      "kerry@napoleon" = {osConfig, ...}: {
        home.file = {
          ".ssh/id_ed25519.pub".source = ./public-keys/kerry_napoleon.pub;
        };
        programs.ssh.settings."*".identityFile = osConfig.sops.secrets."kerry/ssh".path;
      };
      "kerry@panza" = {osConfig, ...}: {
        home.file = {
          ".ssh/id_ed25519.pub".source = ./public-keys/kerry_panza.pub;
        };
        programs.ssh.settings."*".identityFile = osConfig.sops.secrets."kerry/ssh".path;
      };
      "kerry@potato" = {osConfig, ...}: {
        home.file = {
          ".ssh/id_ed25519.pub".source = ./public-keys/kerry_potato.pub;
        };
        programs.ssh.settings."*".identityFile = osConfig.sops.secrets."kerry/ssh".path;
      };
      "kerry@sebastiao" = {osConfig, ...}: {
        home.file = {
          ".ssh/id_ed25519.pub".source = ./public-keys/kerry_sebastiao.pub;
        };
        programs.ssh.settings."*".identityFile = osConfig.sops.secrets."kerry/ssh".path;
      };
    };
  };
}
