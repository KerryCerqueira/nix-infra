{
  self,
  inputs,
  ...
}: let
  hardwareModule = import ./_hardware;
in {
  flake.nixosConfigurations.sigmund = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      hardwareModule
      bluetooth
      gnome
      grub
      nix
      terminal
      thunderbird
      inputs.sops-nix.nixosModules.sops
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
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
