{
  self,
  inputs,
  ...
}: {
  flake.homeConfigurations."kcerqueira@cruncher" = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {system = "x86_64-linux";};
    modules = [
      {
        programs.home-manager.enable = true;
        nixpkgs.config.allowUnfree = true;
        home = {
          stateVersion = "25.05";
          username = "kcerqueira";
          homeDirectory = "/home/kcerqueira";
        };
        nix = {
          package = inputs.nixpkgs.legacyPackages.x86_64-linux.nix;
          settings.experimental-features = [
            "nix-command"
            "flakes"
            "pipe-operators"
          ];
        };
      }
      self.homeModules.neovim
      self.homeModules.shell
    ];
  };
}
