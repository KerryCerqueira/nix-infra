{inputs, ...}: {
  flake.nixosModules.grub = {pkgs, ...}: {
    boot.loader = {
      systemd-boot.enable = false;
      grub = {
        enable = true;
        configurationLimit = 3;
        device = "nodev";
        useOSProber = true;
        efiSupport = true;
        theme = inputs.nixos-grub-themes.packages.${pkgs.system}.hyperfluent;
      };
      efi.canTouchEfiVariables = true;
    };
  };
}
