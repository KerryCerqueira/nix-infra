{
  self,
  lib,
  ...
}: {
  flake.nixosModules = let
    module = {
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
    };
    deployments = (
      lib.genAttrs
      [
        "claudius-core"
        "mushu-core"
        "napoleon"
        "panza"
        "potato"
        "sebastiao"
      ]
      (_: {imports = [self.nixosModules.nix];})
    );
  in {
    flake.nixosModules = lib.mkMerge [
      module
      deployments
    ];
  };
}
