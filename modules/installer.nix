{
  inputs,
  self,
  lib,
  ...
}: {
  flake = {
    nixosModules = let
      module = {
        installer = {
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
      };
      deployments = (
        lib.genAttrs
        [
          "claudius-installer"
          "mushu-installer"
        ]
        (_: {imports = [self.nixosModules.installer];})
      );
    in
      lib.mkMerge [module deployments];
  };
}
