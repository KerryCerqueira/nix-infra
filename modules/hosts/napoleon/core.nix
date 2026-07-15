{
  self,
  inputs,
  ...
}: {
  flake = {
    nixosModules.napoleon = {config, ...}: {
      system.stateVersion = "25.11";
      i18n.defaultLocale = "en_CA.UTF-8";
    };
    nixosConfigurations.napoleon = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [self.nixosModules.napoleon];
    };
    homeModules.napoleon.home.stateVersion = "25.11";
  };
}
