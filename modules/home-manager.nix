{
  self,
  inputs,
  lib,
  ...
}: let
  home-manager-settings = {lib, ...}: {
    home-manager = {
      useGlobalPkgs = lib.mkDefault true;
      useUserPackages = lib.mkDefault true;
      backupFileExtension = lib.mkDefault "bak";
      sharedModules = [
        inputs.sops-nix.homeManagerModules.sops
      ];
    };
  };
  module = {
    home-manager.imports = [
      inputs.home-manager.nixosModules.home-manager
      home-manager-settings
    ];
  };
  module-stable = {
    home-manager-stable.imports = [
      inputs.home-manager-stable.nixosModules.home-manager
      home-manager-settings
    ];
  };
  deployments = (
    lib.genAttrs
    [
      "claudius"
      "napoleon"
      "panza"
      "potato"
      "sebastiao"
    ]
    (_: {imports = [self.nixosModules.home-manager];})
  );
  deployments-stable = (
    lib.genAttrs
    [
      "mushu"
    ]
    (_: {imports = [self.nixosModules.home-manager-stable];})
  );
in {
  flake.nixosModules = lib.mkMerge [
    module
    module-stable
    deployments
    deployments-stable
  ];
}
