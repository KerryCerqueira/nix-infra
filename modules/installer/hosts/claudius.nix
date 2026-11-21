{
  config,
  inputs,
  ...
}: {
  flake = {
    nixosModules.claudius-installer = {
      isoImage.storeContents = [
        config.flake.nixosConfigurations.claudius.config.system.build.toplevel
      ];
    };
    nixosConfigurations.claudius-installer = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [config.flake.nixosModules.claudius-installer];
    };
  };
}
