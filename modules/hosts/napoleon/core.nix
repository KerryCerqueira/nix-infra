{
  self,
  inputs,
  ...
}: {
  flake = {
    nixosModules.napoleon = {config, ...}: {
      system.stateVersion = "25.11";
      time.timeZone = "America/Toronto";
      i18n.defaultLocale = "en_CA.UTF-8";
    };
    nixosConfigurations.napoleon = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = with self.nixosModules; [
        napoleon
      ];
    };
    homeModules = {
      napoleon = {
        home.stateVersion = "25.11";
      };
      "kerry@napoleon" = {imports = [self.homeModules.napoleon];};
      "erika@napoleon" = {imports = [self.homeModules.napoleon];};
    };
  };
}
