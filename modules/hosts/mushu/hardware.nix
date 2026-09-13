{inputs, ...}: {
  flake.nixosModules.mushu-core = {pkgs, ...}: {
    imports = [inputs.nixos-hardware.nixosModules.microsoft-surface-common];
    boot = {
      initrd.availableKernelModules = [
        "xhci_pci"
        "nvme"
      ];
      initrd.kernelModules = [
        "i915"
      ];
      kernelModules = ["kvm-intel"];
      kernelParams = ["i915.enable_psr=0"];
    };
    networking.networkmanager.wifi.powersave = false;
    powerManagement.enable = true;
    security.rtkit.enable = true;
    services = {
      fwupd.enable = true;
      logind.settings.Login = {
        HandleLidSwitch = "suspend-then-hibernate";
        HandleLidSwitchExternalPower = "suspend-then-hibernate";
        HandleLidSwitchDocked = "ignore";
        HandleSuspendKey = "suspend-then-hibernate";
        IdleAction = "suspend-then-hibernate";
        IdleActionSec = "30min";
      };
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
      thermald.enable = true;
    };
    hardware = {
      microsoft-surface.kernelVersion = "stable";
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
  };
}
