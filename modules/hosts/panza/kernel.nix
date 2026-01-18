{
  flake.nixosModules.panza = {
    boot = {
      initrd.availableKernelModules = ["xhci_pci" "nvme" "usb_storage" "sd_mod"];
      kernelModules = ["kvm-intel"];
      kernelParams = ["i915.enable_guc=2"];
    };
  };
}
