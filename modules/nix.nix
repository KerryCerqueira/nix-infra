{self, ...}: {
  flake.nixosModules = {
    nix = {lib, ...}: {
      nix = {
        gc = {
          automatic = lib.mkDefault true;
          dates = lib.mkDefault "weekly";
        };
        settings.experimental-features = [
          "nix-command"
          "flakes"
          "pipe-operators"
        ];
      };
    };
    claudius = {imports = [self.nixosModules.nix];};
    napoleon = {imports = [self.nixosModules.nix];};
    panza = {imports = [self.nixosModules.nix];};
    potato = {imports = [self.nixosModules.nix];};
    sebastiao = {imports = [self.nixosModules.nix];};
  };
}
