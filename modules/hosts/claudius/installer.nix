{
  inputs,
  self,
  ...
}: {
  flake = {
    nixosModules.claudius-installer = {
      modulesPath,
      pkgs,
      ...
    }: {
      imports = [
        "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
      ];
      # isoImage.storeContents = [
      #   self.nixosConfigurations.claudius.config.system.build.toplevel
      # ];
      environment.systemPackages = [
        inputs.disko.packages.${pkgs.stdenv.hostPlatform.system}.disko-install
        (self.packages.${pkgs.stdenv.hostPlatform.system}.neovim.wrap {
          aspects.lang.nix.enable = true;
        })
      ];
    };
    nixosConfigurations.claudius-installer = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [self.nixosModules.claudius-installer];
    };
  };
}
