{
  config,
  inputs,
  ...
}: let
  stateVersion = "26.11";
in {
  flake = {
    nixosModules.claudius = {
      system.stateVersion = stateVersion;
      sops = {
        defaultSopsFile = ./secrets.yaml;
        defaultSopsFormat = "yaml";
      };
    };
    nixosConfigurations.claudius = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [config.flake.nixosModules.claudius];
    };
    homeModules = {
      claudius.home.stateVersion = stateVersion;
      kerry-claudius.imports = [config.flake.homeModules.claudius];
    };
  };
}
