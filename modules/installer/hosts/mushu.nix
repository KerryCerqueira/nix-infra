{
  config,
  inputs,
  ...
}: {
  flake = {
    nixosModules.mushu-installer = {
      isoImage.storeContents = [
        config.flake.nixosConfigurations.mushu.config.system.build.toplevel
      ];
    };
    nixosConfigurations.mushu-installer = inputs.nixpkgs-stable.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [config.flake.nixosModules.mushu-installer];
    };
  };
}
