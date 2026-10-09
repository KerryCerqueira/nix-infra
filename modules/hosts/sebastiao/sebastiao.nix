{
  self,
  inputs,
  ...
}: {
  flake = {
    nixosModules.sebastiao = {
      config,
      lib,
      ...
    }: {
      i18n.defaultLocale = "en_CA.UTF-8";
      services.xserver = {
        enable = true;
        xkb.layout = "us";
        xkb.variant = "";
      };
      networking.hostName = "sebastiao";
      nixpkgs.config.allowUnfree = true;
      system.stateVersion = "25.11";
      sops = {
        defaultSopsFile = ./secrets.yaml;
        defaultSopsFormat = "yaml";
      };
    };
    nixosConfigurations.sebastiao = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [self.nixosModules.sebastiao];
    };
    homeModules.sebastiao.home.stateVersion = "25.11";
  };
  deployments.homeModules.sebastiao = ["kerry-sebastiao"];
}
