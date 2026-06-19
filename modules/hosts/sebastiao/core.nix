{
  self,
  inputs,
  ...
}: {
  flake = {
    nixosModules.sebastiao = {
      config,
      lib,
      ...
    }: {
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
      system.stateVersion = "25.11";
    };
    nixosConfigurations.sebastiao = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [self.nixosModules.sebastiao];
    };
  };
}
