{
  inputs,
  self,
  ...
}: {
  flake = {
    nixosModules.panza-installer = {
      isoImage.storeContents = [
        self.nixosConfigurations.panza.config.system.build.toplevel
      ];
    };
    nixosConfigurations.panza-installer = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [self.nixosModules.panza-installer];
    };
  };
}
