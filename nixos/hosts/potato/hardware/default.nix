{ ... }:

{
	imports = [
		./hardware-configuration.nix
		./sound.nix
		./gpu.nix
	];
	security.rtkit.enable = true;
}

