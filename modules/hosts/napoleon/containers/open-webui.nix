{inputs, ...}: {
  flake.nixosModules.napoleon = let
    owuiStateDir = "/mnt/extra/open-webui";
    owuiUid = 995;
    owuiGid = 993;
    owuiUser = {
      isSystemUser = true;
      group = "open-webui";
      description = "Open WebUI Service User";
      uid = owuiUid;
    };
    owuiGroup = {
      gid = owuiGid;
    };
  in
    {
      config,
      lib,
      ...
    }: {
      containers.open-webui = {
        autoStart = false;
        privateNetwork = false;
        bindMounts = {
          "/var/lib/open-webui" = {
            hostPath = owuiStateDir;
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
        # nixpkgs = inputs.owui-nixpkgs;
        config = {pkgs, ...}: {
          nixpkgs.config = {
            allowUnfree = true;
            rocmSupport = true;
          };
          services.open-webui = {
            enable = true;
            port = 8080;
            host = "127.0.0.1";
            environment = {
              ENABLE_VERSION_UPDATE_CHECK = "False";
              ANONYMIZED_TELEMETRY = "False";
              DO_NOT_TRACK = "True";
              SCARF_NO_ANALYTICS = "True";
              OLLAMA_API_BASE_URL = "http://127.0.0.1:11434";
              ENABLE_SIGNUP = "True";
            };
          };
          system.stateVersion = "25.11";
          users = {
            users.open-webui = owuiUser;
            groups.open-webui = owuiGroup;
          };
          systemd = {
            services.open-webui.serviceConfig = {
              DynamicUser = lib.mkForce false;
              User = "open-webui";
              ReadWritePaths = ["/var/lib/open-webui"];
            };
          };
        };
      };
      networking.firewall.allowedTCPPorts = [8080];
      systemd.tmpfiles.rules = [
        "d ${owuiStateDir} 0700 open-webui open-webui -"
        "d ${owuiStateDir}/data 0700 open-webui open-webui -"
      ];
      users = {
        users.open-webui = owuiUser;
        groups.open-webui = owuiGroup;
      };
    };
}
