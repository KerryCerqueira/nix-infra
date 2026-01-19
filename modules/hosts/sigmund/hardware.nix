{
  flake.nixosModules.sigmund = {
    boot = {
      initrd.availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod"];
      kernelModules = ["kvm-intel"];
    };
    hardware = {
      graphics.enable = true;
      nvidia.open = false;
      cpu.intel.updateMicrocode = true;
    };
    security.rtkit.enable = true;
    services = {
      xserver.videoDrivers = ["nvidia"];
      fwupd.enable = true;
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
    };
  };
}
