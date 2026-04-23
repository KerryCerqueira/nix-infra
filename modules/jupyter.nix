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
  };
  perSystem = {
    pkgs,
    lib,
    ...
  }: let
    shellFromEnv = self.lib.shellFromEnv pkgs;
    jupyterAppFromEnv = env: {
      type = "app";
      program = env |> (self.lib.jupyterAppFromEnv pkgs) |> lib.getExe;
    };
    dataMungeEnv = pkgs.python3.withPackages (ps:
      with ps; [
        pandas
        pydantic
        ipykernel
      ]);
  in {
    devShells.data-munge = shellFromEnv dataMungeEnv;
    apps.data-munge = jupyterAppFromEnv dataMungeEnv;
  };
}
