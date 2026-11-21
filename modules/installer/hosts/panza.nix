{
  config,
  inputs,
  ...
}: {
  flake = {
    nixosModules.panza-installer = {
      isoImage.storeContents = [
        config.flake.nixosConfigurations.panza.config.system.build.toplevel
      ];
    };
    nixosConfigurations.panza-installer = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [config.flake.nixosModules.panza-installer];
    };
  };
}
