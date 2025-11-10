{
  self,
  inputs,
  ...
}: let
  hardwareModule = import ./_hardware;
  kerryHmModule = import ./_home/kerry;
in {
  flake.nixosConfigurations.prometheus = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      hardwareModule
      bluetooth
      gnome
      grub
      nix
      shell
      steam
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
              kerryHmModule
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
