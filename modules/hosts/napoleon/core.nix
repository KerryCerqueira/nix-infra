{
  self,
  inputs,
  ...
}: {
  flake = {
    nixosModules.napoleon = {config, ...}: {
      system.stateVersion = "25.11";
      services = {
        xserver = {
          enable = true;
          xkb.layout = "us";
          xkb.variant = "";
        };
        fwupd.enable = true;
        printing.enable = true;
      };
      time.timeZone = "America/Toronto";
      users.users.root.hashedPasswordFile =
        config.sops.secrets."kerry/hashedPassword".path;
      i18n.defaultLocale = "en_CA.UTF-8";
    };
    nixosConfigurations.napoleon = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = with self.nixosModules; [
        napoleon
      ];
    };
    homeModules = {
      napoleon = {
        home.stateVersion = "25.11";
      };
      "kerry@napoleon" = {imports = [self.homeModules.napoleon];};
      "erika@napoleon" = {imports = [self.homeModules.napoleon];};
    };
  };
}
