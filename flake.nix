{
  description = "Kerry Cerqueira's NixOS system configurations.";

  inputs = {
    catppuccin.url = "github:catppuccin/nix";
    easyeffects-presets = {
      url = "github:JackHack96/EasyEffects-Presets";
      flake = false;
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-config.url = "github:KerryCerqueira/hyprland-config";
    hyprls.url = "github:hyprland-community/hyprls";
    nixos-grub-themes.url = "github:jeslie0/nixos-grub-themes";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {flake-parts, ...} @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} (
      {...}: {
        imports = [
          inputs.home-manager.flakeModules.home-manager
          ./devenvs
          ./home-manager
          ./nixos
        ];
        flake = {
          lib = import ./lib.nix;
        };
        systems = ["x86_64-linux"];
      }
    );
}
