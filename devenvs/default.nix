{self, ...}: {
  flake.perSystem = {pkgs, ...}: let
    shellFromEnv = self.lib.shellFromEnv pkgs;
    jupyterAppFromEnv = self.lib.jupyterAppFromEnv pkgs;
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
