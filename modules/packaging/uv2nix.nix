{
  self,
  inputs,
  ...
}: {
  flake.lib = {
    mkUvDrv = {
      pkgs,
      uv2nix,
      pyproject-build-systems,
    }: {
      pname,
      src,
      entrypoint ? pname,
    }: let
      workspace = uv2nix.lib.workspace.loadWorkspace {
        workspaceRoot = src;
      };
      overlay = workspace.mkPyprojectOverlay {
        sourcePreference = "wheel";
      };
      pythonSet =
        (pkgs.callPackage inputs.pyproject-nix.build.packages {
          python = pkgs.python3;
        }).overrideScope (
          pkgs.lib.composeManyExtensions ([
              pyproject-build-systems.overlays.default
              overlay
            ]
            ++ self.mcp.pythonOverrides)
        );
      venv = pythonSet.mkVirtualEnv "${pname}-env" workspace.deps.default;
    in
      pkgs.writeShellScriptBin pname ''
        exec ${venv}/bin/${entrypoint} "$@"
      '';
  };
}
