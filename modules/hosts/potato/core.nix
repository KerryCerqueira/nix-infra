{
  self,
  inputs,
  ...
}: {
  flake = {
    nixosModules.potato = {
      config,
      lib,
      ...
    }: {
      system.stateVersion = "23.11";
      i18n.defaultLocale = "en_CA.UTF-8";
      nixpkgs.config.allowUnfree = true;
      networking.hostName = "potato";
      networking.networkmanager.enable = true;
      services = {
        displayManager.gdm.enable = true;
        xserver = {
          enable = true;
          xkb = {
            layout = "us";
            variant = "";
          };
        };
        printing.enable = true;
      };
      time.timeZone = "America/Toronto";
    };
    nixosConfigurations.potato = inputs.nixpkgs.lib.nixosSystem {
      modules = [self.nixosModules.potato];
    };
    homeModules = {
      potato = {
        home.stateVersion = "23.11";
      };
      "kerry@potato" = {imports = [self.homeModules.potato];};
      "erika@potato" = {imports = [self.homeModules.potato];};
    };
  };
}
