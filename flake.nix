{
  description = "Kerry Cerqueira's NixOS system configurations.";
  inputs = {
    claude-desktop.url = "github:patrickjaja/claude-desktop-bin";
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko-stable = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-stable = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    import-tree.url = "github:vic/import-tree";
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote-stable = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    jovian = {
      url = "github:Jovian-Experiments/Jovian-NixOS";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-neovim.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";
    pyproject-nix = {
      url = "github:pyproject-nix/pyproject.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pyproject-build-systems = {
      url = "github:pyproject-nix/build-system-pkgs";
      inputs.pyproject-nix.follows = "pyproject-nix";
      inputs.uv2nix.follows = "uv2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix-stable = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    uv2nix = {
      url = "github:pyproject-nix/uv2nix";
      inputs.pyproject-nix.follows = "pyproject-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} (
      {...}: {
        imports = [
          inputs.home-manager.flakeModules.home-manager
          inputs.nix-wrapper-modules.flakeModules.wrappers
          (inputs.import-tree ./modules)
        ];
        flake.flakeModules.lib = ./modules/lib.nix;
        systems = ["x86_64-linux"];
      }
    );
}
