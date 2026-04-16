{self, ...}: {
  flake = {
    nixosModules = {
      ssh = {...}: {
        services.openssh = {
          enable = true;
          settings = {
            PasswordAuthentication = false;
            KbdInteractiveAuthentication = false;
          };
          listenAddresses = [
            {
              addr = "127.0.0.1";
              port = 22;
            }
            {
              addr = "::1";
              port = 22;
            }
          ];
        };
      };
      claudius = {imports = [self.nixosModules.ssh];};
    };
    homeModules = {
      ssh = {...}: {
        programs.ssh = {
          enable = true;
          includes = ["~/.ssh/config.d/*.conf"];
          matchBlocks = {
            "*" = {
              identitiesOnly = true;
              serverAliveInterval = 15;
              serverAliveCountMax = 3;
              extraOptions = {
                AddKeysToAgent = "yes";
              };
            };
            "github" = {
              hostname = "github.com";
              user = "git";
            };
          };
        };
      };
      kerry = {imports = [self.homeModules.ssh];};
    };
  };
}
