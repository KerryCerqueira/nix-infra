{
  self,
  inputs,
  ...
}: {
  flake.homeModules.mcp = {
    pkgs,
    lib,
    ...
  }: {
    programs.mcp.servers.fetchaller = {
      command =
        lib.getExe
        self.packages.${pkgs.system}.fetchaller-mcp;
      args = [];
    };
  };
  perSystem = {
    pkgs,
    ...
  }: let
    mkPythonMcp = self.lib.mkPythonMcp {
      inherit pkgs;
      inherit (inputs) uv2nix pyproject-build-systems;
    };
  in {
    packages.fetchaller-mcp = mkPythonMcp {
      pname = "fetchaller-mcp";
      entrypoint = "fetchaller-mcp";
      src = pkgs.fetchFromGitHub {
        owner = "Averyy";
        repo = "fetchaller-mcp";
        rev = "7c0ccfdfdf586b274f186e56c6b8087749ae7bae"; # v3.2.0
        hash = "sha256-kK+88B2hMlcyBEy9YYvDGFoChW6Q32hMr0k5/EE9gIQ="; # TOFU
      };
    };
  };
}
