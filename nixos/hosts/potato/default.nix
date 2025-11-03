{
  self,
  inputs,
  ...
}: let
  hardwareModule = import ./_hardware;
in {
  flake.nixosConfigurations.potato = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      hardwareModule
      bluetooth
      gnome
      grub
      nix
      steam
      shell
      inputs.sops-nix.nixosModules.sops
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.erika = {
            imports = [
              self.homeModules.erika
              ./_home/erika
            ];
          };
          users.kerry = {
            imports = [
              self.homeModules.kerry
              ./_home/kerry
            ];
          };
          backupFileExtension = "bkp";
          sharedModules = [
            inputs.sops-nix.homeManagerModules.sops
          ];
        };
      }
    ];
  };
}
