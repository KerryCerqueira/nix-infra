{
  flake.nixosModules.sigmund = {
    boot = {
      initrd.availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod"];
      kernelModules = ["kvm-intel"];
    };
    hardware.graphics.enable = true;
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia.open = false;
    hardware.cpu.intel.updateMicrocode = true;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      fwupd.enable = true;
    };
  };
}
