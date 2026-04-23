{self, inputs, ...}: {
  perSystem = {pkgs, ...}: let
  mkUvDrv = self.lib.mkUvDrv {
    inherit pkgs;
    inherit (inputs) uv2nix pyproject-build-systems;
  };
  in {
    packages.mcpo = mkUvDrv {
      pname = "mcpo";
      entrypoint = "mcpo";
      src = pkgs.fetchFromGitHub {
        owner = "open-webui";
        repo = "mcpo";
        rev = "788ff92e5288a899a743a252edd5748f4ad4ab1f";
        hash = "sha256-tA1KdcfmNPuqPbwE66jRY85tsrOKjPImsxSoGsW5ZD4=";
      };
    };
  };
}
