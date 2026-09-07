{
  inputs,
  self,
  ...
}: {
  flake = {
    nixosModules.mushu-installer = {
      modulesPath,
      pkgs,
      ...
    }: {
      imports = [
        "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
      ];
      isoImage.storeContents = [
        self.nixosConfigurations.mushu.config.system.build.toplevel
      ];
      environment.systemPackages = [
        inputs.disko.packages.${pkgs.stdenv.hostPlatform.system}.disko-install
        (self.packages.${pkgs.stdenv.hostPlatform.system}.neovim.wrap {
          aspects.lang.nix.enable = true;
        })
      ];
    };
    nixosConfigurations.mushu-installer = inputs.nixpkgs-stable.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [self.nixosModules.mushu-installer];
    };
  };
}
