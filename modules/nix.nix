{
  flake.nixosModules.nix = {lib, ...}: {
    nix = {
      gc = {
        automatic = lib.mkDefault true;
        dates = lib.mkDefault "weekly";
      };
      settings.experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];
    };
  };
  deployments.nixosModules.nix = [
    "claudius-core"
    "mushu-core"
    "napoleon"
    "panza"
    "sebastiao"
  ];
}
