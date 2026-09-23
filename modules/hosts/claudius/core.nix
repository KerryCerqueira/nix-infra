{
  flake.nixosModules.claudius-core = {
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
  deployments.nixosModules.claudius-core = [
    "claudius"
    "claudius-installer"
  ];
}
