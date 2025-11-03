{
  self,
  inputs,
  ...
}: let
  hardwareModule = import ./_hardware;
  kerryHmModule = import ./_home/kerry;
  erikaHmModule = import ./_home/erika;
in {
  flake = {
    nixosConfigurations.panza = inputs.nixpkgs.lib.nixosSystem {
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
                kerryHmModule
                self.homeModules.kerry
                self.homeModules.easyeffects
              ];
            };
            users.erika = {
              imports = [
                erikaHmModule
                self.homeModules.easyeffects
                self.homeModules.erika
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
  };
}
