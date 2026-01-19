{
  self,
  inputs,
  ...
}: {
  flake.nixosModues.sigmund = {
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
      users.kerry = {
        imports = [
          self.homeModules.kerry
          ./_home/kerry
        ];
      };
      backupFileExtension = "bkp";
      sharedModules = [
        inputs.sops-nix.homeManagerModules.sops
      ];
    };
  };
  flake.nixosConfigurations.sigmund = {
  };
}
