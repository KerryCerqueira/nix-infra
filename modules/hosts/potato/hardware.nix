{...}: {
  flake.nixosModules.potato = {
    config,
    lib,
    ...
  }: {
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
