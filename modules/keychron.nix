{self, ...}: {
  flake = {
    nixosModules.keychron = {
      hardware.keyboard.qmk = {
        enable = true;
        keychronSupport = true;
      };
    };
    nixosModules.napoleon = {imports = [self.nixosModules.keychron];};
  };
}
