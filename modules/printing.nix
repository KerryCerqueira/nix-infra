{self, ...}: {
  flake.nixosModules = {
    printing.services.printing.enable = true;
    claudius.imports = [self.nixosModules.printing];
    panza.imports = [self.nixosModules.printing];
  };
}
