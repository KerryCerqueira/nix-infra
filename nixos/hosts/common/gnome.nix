{ pkgs, ... }:

{
	powerManagement.enable = true;
	services = {
		desktopManager.gnome.enable = true;
		xserver.excludePackages = [ pkgs.xterm ];
		udev.packages = with pkgs; [ gnome-settings-daemon ];
	};
	environment = {
		gnome.excludePackages = with pkgs; [
			orca
			geary
			gnome-tour
			gnome-music
			gnome-terminal
			epiphany
			gnome-calendar
			gnome-console
			gnome-contacts
			gnome-connections
			gnome-music
			totem
		];
		systemPackages = (with pkgs; [
			kitty
		]) ++ (with pkgs.gnomeExtensions; [
				appindicator
				auto-move-windows
				caffeine
				clipboard-indicator
				easyeffects-preset-selector
				paperwm
				places-status-indicator
				launch-new-instance
				removable-drive-menu
				vitals
				impatience
				runcat
			]);
	};
	programs = {
		dconf.enable = true;
		kdeconnect = {
			enable = true;
			package = pkgs.gnomeExtensions.gsconnect;
		};
	};
	networking.networkmanager.plugins = with pkgs; [
		networkmanager-openconnect
	];
}
