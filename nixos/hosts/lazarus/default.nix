{ ... }:

{
	imports = [
		./hardware
		../common/grub.nix
		../common/steam.nix
		../common/thunderbird.nix
		../common/shell.nix
	];
	system.stateVersion = "23.11";
	nix.settings.experimental-features = [
		"nix-command"
		"flakes"
		"pipe-operators"
	];
	nixpkgs.config.allowUnfree = true;
	networking.hostName = "lazarus";
	networking.networkmanager.enable = true;
	time.timeZone = "America/Toronto";
	i18n.defaultLocale = "en_CA.UTF-8";
	sops = {
		defaultSopsFile = ./secrets.yaml;
		defaultSopsFormat = "yaml";
		age.keyFile = let
			envKey = builtins.getEnv "SOPS_AGE_KEY_FILE";
		in
			if envKey == "" then "/etc/age/lazarus.age" else envKey;
		secrets = {
			"hashedUserPasswords/kerry".neededForUsers = true;
			"ageKeys/kerryLazarus" = {
				path = "/home/kerry/.config/sops/age/kerry_lazarus.age";
				owner = "kerry";
			};
		};
	};
	services = {
		displayManager = {
			sddm.enable = true;
			autoLogin.enable = true;
			autoLogin.user = "julie";
		};
		desktopManager.plasma5.enable = true;
		xserver = {
			enable = true;
			xkb.layout = "us";
			xkb.variant = "";
		};
		printing.enable = true;
	};
	users.users.julie= {
		isNormalUser = true;
		description = "Julie Quigley";
		extraGroups = [ "networkmanager" ];
	};
	users.users.kerry = {
		isNormalUser = true;
		description = "Kerry Cerqueira";
		extraGroups = [ "networkmanager" "wheel" ];
	};
}
