{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.installer = moduleWithSystem (
    perSystem @ {config}: {
      modulesPath,
      pkgs,
      ...
    }: {
      imports = ["${modulesPath}/installer/cd-dvd/installation-cd-graphical-gnome.nix"];
      environment.systemPackages = [
        inputs.disko.packages.${pkgs.stdenv.hostPlatform.system}.disko
        pkgs.git
        (perSystem.config.packages.neovim.wrap {
          aspects.lang.nix.enable = true;
        })
      ];
    }
  );
  deployments.nixosModules.installer = [
    "claudius-installer"
    "mushu-installer"
    "panza-installer"
  ];
}
