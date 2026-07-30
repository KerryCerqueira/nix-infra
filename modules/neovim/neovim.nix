{
  self,
  inputs,
  ...
}: {
  flake = {
    nixosModules = {
      neovim = {
        pkgs,
        lib,
        ...
      }: {
        environment.systemPackages = let
          system = pkgs.stdenv.hostPlatform.system;
        in [self.packages.${system}.neovim];
        environment.variables = {
          EDITOR = "nvim";
          VISUAL = "nvim";
        };
      };
      claudius = {imports = [self.nixosModules.neovim];};
      panza = {imports = [self.nixosModules.neovim];};
      potato = {imports = [self.nixosModules.neovim];};
    };
    homeModules = {
      neovim = {
        pkgs,
        lib,
        ...
      }: {
        home.packages = let
          system = pkgs.stdenv.hostPlatform.system;
        in [self.packages.${system}.neovim];
        home.sessionVariables = {
          EDITOR = "nvim";
          VISUAL = "nvim";
        };
      };
      kerry = {imports = [self.homeModules.neovim];};
    };
  };
  perSystem = {system, ...}: {
    wrappers.packages.neovim = true;
    packages.neovim = self.wrappers.neovim.wrap {
      pkgs = import inputs.nixpkgs-neovim {
        inherit system;
        config.allowUnfree = true;
      };
    };
  };
}
