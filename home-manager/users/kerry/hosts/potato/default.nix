{ ... }:

{
	home.stateVersion = "23.11";
	sops = {
		defaultSopsFile = ./secrets.yaml;
		defaultSopsFormat = "yaml";
		age.keyFile = "/home/kerry/.config/sops/age/kerry_potato.age";
		secrets = {
			"syncthing/cert".path = "/home/kerry/.config/syncthing/cert.pem";
			"syncthing/key".path = "/home/kerry/.config/syncthing/key.pem";
			"ssh/github/private".path = "/home/kerry/.ssh/github";
		};
	};
	services.syncthing = {
		enable = true;
		tray.enable = true;
		tray.command = "syncthingtray --wait";
	};
}
