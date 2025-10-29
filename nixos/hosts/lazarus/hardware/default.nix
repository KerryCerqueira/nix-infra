{ ... }:

{
	imports = [
		./hardware-configuration.nix
		./bluetooth.nix
		./sound.nix
	];
	security.rtkit.enable = true;
}
