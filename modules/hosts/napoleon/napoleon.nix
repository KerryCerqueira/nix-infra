{
  self,
  inputs,
  ...
}: {
  flake = {
    nixosModules.napoleon = {config, ...}: {
      networking.hostName = "napoleon";
      system.stateVersion = "25.11";
      i18n.defaultLocale = "en_CA.UTF-8";
      sops = {
        defaultSopsFile = ./secrets.yaml;
        defaultSopsFormat = "yaml";
      };
    };
    nixosConfigurations.napoleon = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [self.nixosModules.napoleon];
    };
    homeModules.napoleon.home.stateVersion = "25.11";
  };
  deployments.homeModules.napoleon = ["jovianUser"];
}
