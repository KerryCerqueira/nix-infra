{
  self,
  inputs,
  ...
}: {
  flake.nixosModules = {
    grub = {pkgs, ...}: {
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
    claudius = {imports = [self.nixosModules.grub];};
    napoleon = {imports = [self.nixosModules.grub];};
    panza = {imports = [self.nixosModules.grub];};
    potato = {imports = [self.nixosModules.grub];};
  };
}
