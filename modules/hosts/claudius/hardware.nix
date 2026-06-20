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
      cpu.amd.updateMicrocode = true;
      enableRedistributableFirmware = true;
    };
    powerManagement.enable = true;
    security.rtkit.enable = true;
    services = {
      fwupd.enable = true;
      logind.settings.Login = {
        HandleLidSwitch = "suspend-then-hibernate";
        HandleLidSwitchExternalPower = "suspend-then-hibernate";
        HandleLidSwitchDocked = "ignore"; # default; closed+docked stays awake
        HandleSuspendKey = "suspend-then-hibernate";
        IdleAction = "suspend-then-hibernate"; # see idle caveat
        IdleActionSec = "30min";
      };
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
    };
    systemd.sleep.settings.Sleep.HibernateDelaySec = "120min";
  };
}
