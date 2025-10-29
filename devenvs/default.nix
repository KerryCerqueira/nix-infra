{self, ...}: {
  perSystem = {pkgs, lib, ...}: let
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
