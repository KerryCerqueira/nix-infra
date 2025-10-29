let
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
	shellFromEnv = pkgs: pythonEnv:
		let
			kernelSpec = kernelSpecFromEnv pkgs pythonEnv;
		in
			pkgs.mkShell {
				buildInputs = with pkgs; [
					pythonEnv
					jupyter
				];
				shellHook = /*bash*/ ''
					export JUPYTER_PATH="${kernelSpec}:''${JUPYTER_PATH:-}"
				'';
			};
	jupyterAppFromEnv = pkgs: pythonEnv:
		let
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
}
