{
  self,
  inputs,
  ...
}: {
  flake = {
    nixosModules.panza = {
      nixpkgs.config.allowUnfree = true;
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
    nixosConfigurations.panza = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [self.nixosModules.panza];
    };
  };
}
