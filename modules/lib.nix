{self, ...}: {
  flake.lib = let
    kernelSpecFromEnv = pkgs: pythonEnv:
      pkgs.writeTextDir
      "kernels/nix_kernel/kernel.json"
      (builtins.toJSON {
        display_name = "Nix Shell Kernel";
        language = "python";
        argv = [
          "${pythonEnv}/bin/python"
          "-m"
          "ipykernel_launcher"
          "-f"
          "{connection_file}"
        ];
        env = {};
      });
  in {
    inherit kernelSpecFromEnv;
    shellFromEnv = pkgs: pythonEnv: let
      kernelSpec = kernelSpecFromEnv pkgs pythonEnv;
    in
      pkgs.mkShell {
        buildInputs = with pkgs; [
          pythonEnv
          jupyter
        ];
        shellHook = ''
          export JUPYTER_PATH="${kernelSpec}:''${JUPYTER_PATH:-}"
        '';
      };
    jupyterAppFromEnv = pkgs: pythonEnv: let
      kernelSpec = kernelSpecFromEnv pkgs pythonEnv;
    in
      pkgs.writeShellApplication {
        name = "jupyter-data-munging";
        runtimeInputs = [
          pkgs.jupyter
          pythonEnv
        ];
        text = ''
          export JUPYTER_PATH="${kernelSpec}:''${JUPYTER_PATH:-}"
          exec jupyter lab "$@"
        '';
      };
    mkPythonMcp = {
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
        (pkgs.callPackage self.inputs.pyproject-nix.build.packages {
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
