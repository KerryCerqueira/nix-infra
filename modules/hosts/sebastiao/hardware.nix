{inputs, ...}: {
  flake.nixosModules.sebastiao = {pkgs, ...}: {
    imports = [inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-yoga];
    boot = {
      initrd.availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "nvme"
      ];
      kernelParams = [
        "zswap.enabled=1"
        "zswap.max_pool_percent=20"
        "zswap.shrinker_enabled=1"
      ];
      kernelModules = ["kvm-intel"];
    };
    powerManagement.enable = true;
    security.rtkit.enable = true;
    services = {
      fprintd.enable = true;
      fwupd.enable = true;
      hardware.bolt.enable = true;
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
      thermald.enable = true;
    };
    hardware = {
      enableAllFirmware = true;
      firmware = [pkgs.sof-firmware];
      bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
          General = {
            FastConnectable = true;
            Experimental = true;
            Enable = "Source,Sink,Media,Socket";
          };
        };
      };
      cpu.intel.npu.enable = true;
    };
  };
}
