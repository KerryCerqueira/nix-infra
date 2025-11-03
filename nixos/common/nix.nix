{...}: {
  flake.nixosModules.nix = {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];
    nixpkgs.config.allowUnfree = true;
  };
}
