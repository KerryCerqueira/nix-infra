{
  self,
  inputs,
  ...
}: {
  flake.nixosModules = {
    home-manager = {lib, ...}: {
      imports = [inputs.home-manager.nixosModules.home-manager];
      home-manager = {
        useGlobalPkgs = lib.mkDefault true;
        useUserPackages = lib.mkDefault true;
        backupFileExtension = lib.mkDefault "bkp";
        sharedModules = [
          inputs.sops-nix.homeManagerModules.sops
        ];
      };
    };
    claudius = {imports = [self.nixosModules.home-manager];};
    napoleon = {imports = [self.nixosModules.home-manager];};
    panza = {imports = [self.nixosModules.home-manager];};
    potato = {imports = [self.nixosModules.home-manager];};
    sebastiao = {imports = [self.nixosModules.home-manager];};
  };
}
