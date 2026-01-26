{inputs, ...}: {
  flake.nixosModules.panza = {pkgs, ...}: {
    imports = [
      inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-yoga
    ];
    boot = {
      initrd.availableKernelModules = ["xhci_pci" "nvme" "usb_storage" "sd_mod"];
      kernelModules = ["kvm-intel"];
      kernelParams = ["i915.enable_guc=2"];
    };
    security.rtkit.enable = true;
    services = {
      hardware.bolt.enable = true;
      throttled.enable = true;
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
    };
    hardware = {
      enableAllFirmware = true;
      firmware = [pkgs.sof-firmware];
      bluetooth.enable = true;
      bluetooth.powerOnBoot = true;
    };
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      memoryPercent = 100;
    };
  };
}
