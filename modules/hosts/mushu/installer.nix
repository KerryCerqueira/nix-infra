{
  inputs,
  self,
  ...
}: {
  flake = {
    nixosModules.mushu-installer = {
      isoImage.storeContents = [
        self.nixosConfigurations.mushu.config.system.build.toplevel
      ];
    };
    nixosConfigurations.mushu-installer = inputs.nixpkgs-stable.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [self.nixosModules.mushu-installer];
    };
  };
}
