{
  config,
  inputs,
  ...
}: {
  flake = let
    stateVersion = "26.05";
  in {
    nixosModules.mushu.system.stateVersion = stateVersion;
    nixosConfigurations.mushu = inputs.nixpkgs-stable.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [config.flake.nixosModules.mushu];
    };
    homeModules = {
      mushu.home.stateVersion = stateVersion;
      erika-mushu.imports = [config.flake.homeModules.mushu];
      julie-mushu.imports = [config.flake.homeModules.mushu];
      kerry-mushu.imports = [config.flake.homeModules.mushu];
    };
  };
}
