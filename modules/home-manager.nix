{inputs, ...}: let
  home-manager-settings = {lib, ...}: {
    home-manager = {
      useGlobalPkgs = lib.mkDefault true;
      useUserPackages = lib.mkDefault true;
      backupFileExtension = lib.mkDefault "bak";
    };
  };
in {
  flake.nixosModules = {
    home-manager.imports = [
      inputs.home-manager.nixosModules.home-manager
      home-manager-settings
    ];
    home-manager-stable.imports = [
      inputs.home-manager-stable.nixosModules.home-manager
      home-manager-settings
    ];
  };
  deployments.nixosModules = {
    home-manager = [
      "claudius"
      "napoleon"
      "panza"
      "sebastiao"
    ];
    home-manager-stable = ["mushu"];
  };
}
