{
  flake.nixosModules.napoleon = {pkgs, ...}: {
    nixpkgs = {
      config.allowUnfree = true;
      overlays = [
        (final: prev: {
          btop = prev.btop.override {
            rocmSupport = true;
          };
        })
      ];
    };
  };
}
