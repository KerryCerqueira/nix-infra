{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.claudius = {
    config,
    lib,
    ...
  }: {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];
    time.timeZone = "America/Toronto";
    i18n.defaultLocale = "en_CA.UTF-8";
    services = {
      xserver = {
        enable = true;
        xkb.layout = "us";
        xkb.variant = "";
      };
      printing.enable = true;
    };
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "24.11";
  };
  flake.nixosConfigurations.claudius = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = with self.nixosModules; [
      claudius
    ];
  };
}
