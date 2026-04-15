{inputs, ...}: {
  flake.nixosModules.napoleon = {
    config,
    lib,
    pkgs,
    ...
  }: let
    ollamaDataDir = "/mnt/extra/ollama";
    ollamaUid = 994;
    ollamaGid = 992;
    ollamaUser = {
      isSystemUser = true;
      group = "ollama";
      description = "Ollama Service User";
      extraGroups = ["video" "render"];
      uid = ollamaUid;
    };
    ollamaGroup = {
      gid = ollamaGid;
    };
  in {
    containers.ollama = {
      autoStart = false;
      privateNetwork = false;
      bindMounts = {
        "/var/lib/ollama" = {
          hostPath = ollamaDataDir;
          isReadOnly = false;
        };
        "/dev/kfd" = {
          hostPath = "/dev/kfd";
          isReadOnly = false;
        };
        "/dev/dri" = {
          hostPath = "/dev/dri";
          isReadOnly = false;
        };
        "/run/opengl-driver" = {
          hostPath = "/run/opengl-driver";
          isReadOnly = true;
        };
      };
      allowedDevices = [
        {
          node = "/dev/kfd";
          modifier = "rw";
        }
        {
          node = "/dev/dri/card0";
          modifier = "rw";
        }
        {
          node = "/dev/dri/renderD128";
          modifier = "rw";
        }
      ];
      config = {pkgs, ...}: {
        system.stateVersion = "25.11";
        nixpkgs.config = {
          allowUnfree = true;
          rocmSupport = true;
        };
        services.ollama = {
          enable = true;
          environmentVariables = {
            OLLAMA_NUM_PARALLEL = "1";
            OLLAMA_FLASH_ATTENTION = "1";
            OLLAMA_KV_CACHE_TYPE = "q8_0";
          };
          package = pkgs.ollama-rocm;
          host = "127.0.0.1";
          port = 11434;
          user = "ollama";
          group = "ollama";
        };
        users = {
          users.ollama = ollamaUser;
          groups.ollama = ollamaGroup;
        };
        systemd = {
          services.ollama.serviceConfig = {
            DynamicUser = lib.mkForce false;
            User = "ollama";
            ReadWritePaths = ["/var/lib/ollama"];
          };
        };
      };
    };
    systemd = {
      tmpfiles.rules = [
        "d ${ollamaDataDir} 0755 ollama ollama -"
          "d ${ollamaDataDir}/models 0755 ollama ollama -"
      ];
    };
    users = {
      users.ollama = ollamaUser;
      groups.ollama = ollamaGroup;
    };
  };
}
