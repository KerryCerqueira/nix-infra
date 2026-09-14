{
  self,
  inputs,
  ...
}: let
  stateVersion = "26.11";
in {
  flake = {
    nixosModules.claudius.system.stateVersion = stateVersion;
    nixosConfigurations.claudius = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [self.nixosModules.claudius];
    };
    homeModules = {
      claudius.home.stateVersion = stateVersion;
      "kerry@claudius".imports = [self.homeModules.claudius];
    };
  };
}
