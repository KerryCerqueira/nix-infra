{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.claudius = {
    config,
    lib,
    ...
  }: {
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
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "24.11";
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "bkp";
      sharedModules = [
        inputs.sops-nix.homeManagerModules.sops
      ];
    };
  };
  flake.nixosConfigurations.claudius = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = with self.nixosModules; [
      claudius
    ];
  };
}
