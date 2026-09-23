{
  flake.nixosModules.mushu-core = {
    i18n.defaultLocale = "en_CA.UTF-8";
    services = {
      xserver = {
        enable = true;
        xkb.layout = "us";
        xkb.variant = "";
      };
    };
    networking.hostName = "mushu";
    nixpkgs.config.allowUnfree = true;
  };
  deployments.nixosModules.mushu-core = [
    "mushu"
    "mushu-installer"
  ];
}
