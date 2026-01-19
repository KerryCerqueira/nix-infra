{...}: {
  flake.nixosModules.nix = {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];
    nixpkgs.overlays = [
# Fixes jupytext build failure on unstable 01/19/2024
      (final: prev: {
        pythonPackagesExtensions =
          prev.pythonPackagesExtensions
          ++ [
            (python-final: python-prev: {
              jupytext = python-prev.jupytext.overridePythonAttrs (oldAttrs: {
                doCheck = false;
              });
            })
          ];
      })
    ];
  };
}
