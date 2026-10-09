{
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
    napoleon.nixpkgs = {
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
  deployments.nixosModules.nix = [
    "claudius-core"
    "mushu-core"
    "napoleon"
    "panza"
    "sebastiao"
  ];
}
