{
  flake.nixosModules.napoleon = {pkgs, ...}: {
    boot = {
      initrd.kernelModules = ["amdgpu"];
      kernelModules = [
        "k10temp"
        "nct6775"
        "kvm-amd"
      ];
      kernelPackages = pkgs.linuxPackages_latest;
      initrd.availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
    };
    services = {
      xserver.videoDrivers = ["amdgpu"];
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
    };
    hardware = {
      bluetooth.enable = true;
      bluetooth.powerOnBoot = true;
      cpu.amd.updateMicrocode = true;
      enableAllFirmware = true;
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [rocmPackages.clr.icd];
      };
    };
    security.rtkit.enable = true;
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      memoryPercent = 100;
    };
  };
}
