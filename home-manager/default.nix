{
  self,
  inputs,
  ...
}: {
  flake = {
    homeModules = {
      "erika@potato" = {
        imports = [
          ./users/erika
          ./users/erika/hosts/potato
        ];
      };
      "erika@panza" = {
        imports = [
          ./users/erika
          ./users/erika/hosts/panza
        ];
      };
      "julie@lazarus" = {
        imports = [
          ./users/julie
        ];
      };
      "kcerqueira@cruncher" = {
        imports = [
          ./users/kerry/minimal.nix
        ];
        home = {
          stateVersion = "25.05";
          username = "kcerqueira";
          homeDirectory = "/home/kcerqueira";
        };
      };
      "kerry@counter" = {
        imports = [
          ./users/kerry/minimal.nix
        ];
        home = {
          stateVersion = "25.05";
          username = "kerry";
          homeDirectory = "/home/kerry";
        };
      };
      "kerry@sigmund" = {
        imports = [
          ./users/kerry
          ./users/kerry/hosts/sigmund
        ];
      };
      "kerry@claudius" = {
        imports = [
          ./users/kerry
          ./users/kerry/hosts/claudius
        ];
      };
      "kerry@lazarus" = {
        imports = [
          ./users/kerry
          ./users/kerry/hosts/lazarus
        ];
      };
      "kerry@panza" = {
        imports = [
          ./users/kerry
          ./users/kerry/hosts/panza
        ];
      };
      "kerry@potato" = {
        imports = [
          ./users/kerry
          ./users/kerry/hosts/potato
        ];
      };
    };
    homeConfigurations = {
      "kerry@counter" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.nixpkgs {system = "x86_64-linux";};
        modules = [
          self.homeModules."kerry@counter"
        ];
        extraSpecialArgs = {
          inherit inputs;
        };
      };
      "kcerqueira@cruncher" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.nixpkgs {system = "x86_64-linux";};
        modules = [
          self.homeModules."kcerqueira@cruncher"
        ];
        extraSpecialArgs = {
          inherit inputs;
        };
      };
    };
  };
}
