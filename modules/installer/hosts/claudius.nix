{
  inputs,
  self,
  ...
}: {
  flake = {
    nixosModules.claudius-installer = {
      isoImage.storeContents = [
        self.nixosConfigurations.claudius.config.system.build.toplevel
      ];
    };
    nixosConfigurations.claudius-installer = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [self.nixosModules.claudius-installer];
    };
  };
}
