{...}: {
  flake.nixosModules.potato = {
    pkgs,
    config,
    lib,
    ...
  }: let
    fanConfig = pkgs.writeText "hp-spectre-15-df-fan.json" (builtins.toJSON {
      LegacyTemperatureThresholdsBehaviour = true;
      NotebookModel = "HP Spectre x360 Convertible 15-df";
      Author = "Kerry (modified)";
      EcPollInterval = 3000;
      ReadWriteWords = false;
      CriticalTemperature = 95;
      FanConfigurations = [
        {
          ReadRegister = 88;
          WriteRegister = 244;
          MinSpeedValue = 35;
          MaxSpeedValue = 99;
          IndependentReadMinMaxValues = true;
          MinSpeedValueRead = 35;
          MaxSpeedValueRead = 99;
          ResetRequired = true;
          FanSpeedResetValue = 0;
          FanDisplayName = "CPU Fan";
          TemperatureThresholds = [
            {
              UpThreshold = 30;
              DownThreshold = 0;
              FanSpeed = 0.0;
            }
            {
              UpThreshold = 49;
              DownThreshold = 35;
              FanSpeed = 10.0;
            }
            {
              UpThreshold = 55;
              DownThreshold = 47;
              FanSpeed = 25.0;
            }
            {
              UpThreshold = 65;
              DownThreshold = 53;
              FanSpeed = 50.0;
            }
            {
              UpThreshold = 75;
              DownThreshold = 63;
              FanSpeed = 75.0;
            }
            {
              UpThreshold = 85;
              DownThreshold = 73;
              FanSpeed = 100.0;
            }
          ];
          FanSpeedPercentageOverrides = [
            {
              FanSpeedPercentage = 0.0;
              FanSpeedValue = 35;
              TargetOperation = "Write";
            }
            {
              FanSpeedPercentage = 25.0;
              FanSpeedValue = 42;
              TargetOperation = "Write";
            }
            {
              FanSpeedPercentage = 50.0;
              FanSpeedValue = 61;
              TargetOperation = "Write";
            }
            {
              FanSpeedPercentage = 75.0;
              FanSpeedValue = 80;
              TargetOperation = "Write";
            }
            {
              FanSpeedPercentage = 100.0;
              FanSpeedValue = 99;
              TargetOperation = "Write";
            }
          ];
        }
      ];
    });
    nbfcConfig = pkgs.writeText "nbfc.json" (builtins.toJSON {
      SelectedConfigId = "${fanConfig}";
      EmbeddedControllerType = "dev_port";
    });
  in {
    boot = {
      initrd.availableKernelModules = [
        "xhci_pci"
        "nvme"
        "usb_storage"
        "sd_mod"
        "rtsx_pci_sdmmc"
      ];
      initrd.kernelModules = [];
      kernelModules = ["kvm-intel"];
      extraModulePackages = [];
    };
    environment.systemPackages = [pkgs.nbfc-linux];
    security.rtkit.enable = true;
    services = {
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
      xserver = {
        videoDrivers = ["nvidia"];
      };
    };
    systemd.services.nbfc_service = {
      description = "NoteBook FanControl service";
      wantedBy = ["multi-user.target"];
      after = ["multi-user.target"];
      serviceConfig = {
        Type = "simple";
        Restart = "always";
        RestartSec = 5;
      };
      path = [pkgs.kmod];
      script = "${pkgs.nbfc-linux}/bin/nbfc_service --config-file ${nbfcConfig}";
    };
    hardware = {
      bluetooth.enable = true;
      bluetooth.powerOnBoot = true;
      cpu.intel.updateMicrocode =
        lib.mkDefault
        config.hardware.enableRedistributableFirmware;
      graphics.enable = true;
      nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = false;
        nvidiaSettings = true;
        prime = {
          intelBusId = "PCI:0:02:0";
          nvidiaBusId = "PCI:59:00:0";
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };
        };
      };
    };
    networking.useDHCP = lib.mkDefault true;
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
