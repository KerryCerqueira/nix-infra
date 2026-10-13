{
  flake.nixosModules = {
    nix = {lib, ...}: {
      nix = {
        gc = {
          automatic = lib.mkDefault true;
          dates = lib.mkDefault "weekly";
          options = "--delete-older-than 30d";
        };
        settings = {
          experimental-features = [
            "nix-command"
            "flakes"
            "pipe-operators"
          ];
          auto-optimise-store = true;
          trusted-users = ["root" "@wheel"];
          max-jobs = "auto";
          cores = 0;
        };
      };
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
