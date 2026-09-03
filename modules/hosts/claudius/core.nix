{self, ...}: {
  flake = {
    nixosModules = {
      claudius-core = {
        config,
        lib,
        ...
      }: {
        i18n.defaultLocale = "en_CA.UTF-8";
        networking.hostName = "claudius";
        services.xserver = {
          xkb.layout = "us";
          xkb.variant = "";
        };
        nixpkgs.config.allowUnfree = true;
      };
      claudius.imports = [self.nixosModules.claudius-core];
      claudius-installer.imports = [self.nixosModules.claudius-core];
    };
  };
}
