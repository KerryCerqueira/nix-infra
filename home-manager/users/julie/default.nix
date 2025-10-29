{ pkgs, inputs, ... }:

{
	imports = [
		../common/libreoffice.nix
		inputs.nvim-config.homeManagerModules.nvim-config
		inputs.shell-config.homeManagerModules.shell-config
	];
	programs = {
		home-manager.enable = true;
		chromium.enable = true;
		firefox.enable = true;
	};
	home = {
		username = "julie";
		homeDirectory = "/home/julie";
		stateVersion = "23.11";
		packages = with pkgs; [
			xournalpp
			gimp
			thunderbird
			zoom-us
			rnote
			vlc
			spotify
			whatsapp-for-linux
		];
	};
}
