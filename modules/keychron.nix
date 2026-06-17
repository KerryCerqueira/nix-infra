{self, ...}: {
  flake = {
    nixosModules = {
      keychron = {
        hardware.keyboard.qmk = {
          enable = true;
          keychronSupport = true;
        };
      };
      napoleon = {imports = [self.nixosModules.keychron];};
    };
  };
}
