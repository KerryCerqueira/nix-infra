{
  self,
  inputs,
  ...
}: {
  flake = {
    nixosModules.napoleon = {config, ...}: {
      home-manager = {
        backupFileExtension = "bkp";
        sharedModules = [
          inputs.sops-nix.homeManagerModules.sops
        ];
        useGlobalPkgs = true;
        useUserPackages = true;
      };
      system.stateVersion = "25.11";
      services = {
        xserver = {
          enable = true;
          xkb.layout = "us";
          xkb.variant = "";
        };
        fwupd.enable = true;
        printing.enable = true;
      };
      time.timeZone = "America/Toronto";
      users.users.root.hashedPasswordFile =
        config.sops.secrets."hashedUserPasswords/root".path;
      i18n.defaultLocale = "en_CA.UTF-8";
      imports = with self.nixosModules; [
        gnome
        grub
        nix
        steam
        terminal
        thunderbird
        inputs.sops-nix.nixosModules.sops
        inputs.home-manager.nixosModules.home-manager
      ];
    };
    nixosConfigurations.napoleon = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = with self.nixosModules; [
        napoleon
      ];
    };
  };
}
