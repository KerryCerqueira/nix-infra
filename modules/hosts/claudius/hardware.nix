{inputs, ...}: {
  flake.nixosModules.claudius = {...}: {
    imports = [
      inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen2
    ];
    boot = {
      kernelModules = ["kvm-amd"];
      initrd.availableKernelModules = [
        "nvme"
        "xhci_pci"
        "usb_storage"
        "sd_mod"
        "sdhci_pci"
      ];
    };
    hardware = {
      bluetooth.enable = true;
      bluetooth.powerOnBoot = true;
      enableRedistributableFirmware = true;
    };
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
