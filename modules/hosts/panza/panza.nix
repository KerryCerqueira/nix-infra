{
  self,
  inputs,
  ...
}: {
  flake = {
    nixosModules.panza = {
      networking.hostName = "panza";
      nixpkgs.config.allowUnfree = true;
      services.xserver = {
        enable = true;
        xkb.layout = "us";
        xkb.variant = "";
      };
      system.stateVersion = "23.11";
      time.timeZone = "America/Toronto";
      i18n.defaultLocale = "en_CA.UTF-8";
      sops = {
        defaultSopsFile = ./secrets.yaml;
        defaultSopsFormat = "yaml";
      };
    };
    nixosConfigurations.panza = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [self.nixosModules.panza];
    };
    homeModules.panza.home.stateVersion = "23.11";
  };
  deployments.homeModules.panza = [
    "kerry-panza"
    "erika-panza"
  ];
}
