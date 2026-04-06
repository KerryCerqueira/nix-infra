{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.potato = {
    config,
    lib,
    ...
  }: {
    imports = with self.nixosModules; [
      gnome
      grub
      nix
      steam
      inputs.sops-nix.nixosModules.sops
      inputs.home-manager.nixosModules.home-manager
      terminal
    ];
    system.stateVersion = "23.11";
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "bkp";
      sharedModules = [
        inputs.sops-nix.homeManagerModules.sops
      ];
    };
    i18n.defaultLocale = "en_CA.UTF-8";
    nixpkgs.config.allowUnfree = true;
    networking.hostName = "potato";
    networking.networkmanager.enable = true;
    services = {
      displayManager.gdm.enable = true;
      xserver = {
        enable = true;
        xkb = {
          layout = "us";
          variant = "";
        };
      };
      printing.enable = true;
    };
    time.timeZone = "America/Toronto";
  };
  flake.nixosConfigurations.potato = inputs.nixpkgs.lib.nixosSystem {
    modules = [self.nixosModules.potato];
  };
}
