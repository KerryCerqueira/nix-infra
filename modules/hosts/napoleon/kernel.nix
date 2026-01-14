{
  flake.nixosModules.napoleon = {pkgs, ...}: {
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "usb_storage"
      "usbhid"
      "sd_mod"
    ];
    boot.kernelModules = ["kvm-amd"];
    hardware = {
      cpu.amd.updateMicrocode = true;
      enableAllFirmware = true;
    };
  };
}
