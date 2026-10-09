{inputs, ...}: {
  flake.nixosModules.panza = {pkgs, ...}: {
    imports = [inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-yoga];
    boot = {
      initrd.availableKernelModules = [
        "xhci_pci"
        "nvme"
        "usb_storage"
        "sd_mod"
      ];
      kernelModules = ["kvm-intel"];
      kernelParams = ["i915.enable_guc=2"];
    };
    security.rtkit.enable = true;
    services = {
      fprintd.enable = true;
      fwupd.enable = true;
      hardware.bolt.enable = true;
      logind.settings.Login = {
        HandleLidSwitch = "suspend-then-hibernate";
        HandleLidSwitchExternalPower = "suspend-then-hibernate";
        HandleLidSwitchDocked = "ignore";
        HandleSuspendKey = "suspend-then-hibernate";
        IdleAction = "suspend-then-hibernate";
        IdleActionSec = "30min";
      };
      throttled.enable = true;
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
    };
    powerManagement.enable = true;
    systemd.sleep.settings.Sleep.HibernateDelaySec = "120min";
  };
}
