{ ... }:

{
	imports = [
		./hardware
		../common/grub.nix
		../common/gnome.nix
		../common/steam.nix
		../common/shell.nix
	];
	system.stateVersion = "23.11";
	nix.settings.experimental-features = [
		"nix-command"
		"flakes"
		"pipe-operators"
	];
	nixpkgs.config.allowUnfree = true;
	networking.hostName = "potato";
	networking.networkmanager.enable = true;
	time.timeZone = "America/Toronto";
	i18n.defaultLocale = "en_CA.UTF-8";
	sops = {
		defaultSopsFile = ./secrets.yaml;
		defaultSopsFormat = "yaml";
		age.keyFile = let
			envKey = builtins.getEnv "SOPS_AGE_KEY_FILE";
		in
			if envKey == "" then "/etc/age/potato.age" else envKey;
		secrets = {
			"ageKeys/kerryPotato" = {
				path = "/home/kerry/.config/sops/age/kerry_potato.age";
				owner = "kerry";
			};
			"ageKeys/erikaMaster" = {
				path = "/home/erika/.config/sops/age/erika_master.age";
				owner = "erika";
			};
		};
	};
	services = {
		displayManager.gdm.enable = true;
		xserver = {
			enable = true;
			videoDrivers = ["nvidia"];
			xkb = {
				layout = "us";
				variant = "";
			};
		};
		printing.enable = true;
	};
	users = {
		users.erika = {
			isNormalUser = true;
			description = "Erika";
			extraGroups = [ "networkmanager" "wheel" ];
		};
		users.kerry = {
			isNormalUser = true;
			description = "Kerry Cerqueira";
			extraGroups = [ "networkmanager" "wheel" ];
		};
	};
}
