{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.sigmund = {
    imports = with self.nixosModules; [
      gnome
      grub
      nix
      nvim
      terminal
      steam
      thunderbird
      inputs.sops-nix.nixosModules.sops
      inputs.home-manager.nixosModules.home-manager
    ];
    system.stateVersion = "24.11";
    time.timeZone = "America/Toronto";
    i18n.defaultLocale = "en_CA.UTF-8";
    services = {
      xserver = {
        enable = true;
        xkb.layout = "us";
        xkb.variant = "";
      };
      printing.enable = true;
    };
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "bkp";
      sharedModules = [
        inputs.sops-nix.homeManagerModules.sops
      ];
    };
  };
  flake.nixosConfigurations.sigmund = self.inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [ self.nixosModules.sigmund ];
  };
}
