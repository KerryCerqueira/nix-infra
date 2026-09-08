{
  self,
  inputs,
  ...
}: {
  flake = let
    stateVersion = "26.05";
  in {
    nixosModules.mushu.system.stateVersion = stateVersion;
    nixosConfigurations.mushu = inputs.nixpkgs-stable.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [self.nixosModules.mushu];
    };
    homeModules = {
      mushu.home.stateVersion = stateVersion;
      "erika@mushu".imports = [self.homeModules.mushu];
      "julie@mushu".imports = [self.homeModules.mushu];
      "kerry@mushu".imports = [self.homeModules.mushu];
    };
  };
}
