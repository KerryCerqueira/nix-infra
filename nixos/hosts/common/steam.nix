{ pkgs, ... }:

{
	programs = {
		steam = {
			enable = true;
		};
	};
	environment = {
		systemPackages = with pkgs; [
			mangohud
		];
		variables = {
			STEAM_FORCE_DESKTOPUI_SCALING = "2";
		};
	};
}
