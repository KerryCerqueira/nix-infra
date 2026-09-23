{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.installer = {
    modulesPath,
    pkgs,
    ...
  }: {
    imports = ["${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"];
    environment.systemPackages = [
      inputs.disko.packages.${pkgs.stdenv.hostPlatform.system}.disko
      pkgs.git
      (self.packages.${pkgs.stdenv.hostPlatform.system}.neovim.wrap {
        aspects.lang.nix.enable = true;
      })
    ];
  };
  deployments.nixosModules.installer = [
    "claudius-installer"
    "mushu-installer"
  ];
}
