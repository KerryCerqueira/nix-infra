{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.panza = {
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
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "bkp";
      sharedModules = [
        inputs.sops-nix.homeManagerModules.sops
      ];
    };
    services = {
      xserver = {
        enable = true;
        xkb.layout = "us";
        xkb.variant = "";
      };
      printing.enable = true;
    };
    system.stateVersion = "23.11";
    time.timeZone = "America/Toronto";
    i18n.defaultLocale = "en_CA.UTF-8";
  };
  flake.nixosConfigurations.panza = self.inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [self.nixosModules.panza];
  };
}
