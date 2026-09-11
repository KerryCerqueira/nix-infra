{
  self,
  inputs,
  lib,
  ...
}: let
  module = {sops.imports = [inputs.sops-nix.nixosModules.sops];};
  module-stable = {sops-stable.imports = [inputs.sops-nix-stable.nixosModules.sops];};
  deployments = (
    lib.genAttrs
    [
      "claudius"
      "napoleon"
      "panza"
      "potato"
      "sebastiao"
    ]
    (_: {imports = [self.nixosModules.sops];})
  );
  deployments-stable = (
    lib.genAttrs
    [
      "mushu"
    ]
    (_: {imports = [self.nixosModules.sops-stable];})
  );
in {
  flake.nixosModules = lib.mkMerge [
    module
    module-stable
    deployments
    deployments-stable
  ];
}
