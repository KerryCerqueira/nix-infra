{ ... }:

{
	home.stateVersion = "23.11";
	sops = {
		defaultSopsFile = ./secrets.yaml;
		defaultSopsFormat = "yaml";
		age.keyFile = "/home/kerry/.config/sops/age/kerry_lazarus.age";
		secrets = {
			"syncthing/cert".path = "/home/kerry/.config/syncthing/cert.pem";
			"syncthing/key".path = "/home/kerry/.config/syncthing/key.pem";
			"ssh/github/private".path = "/home/kerry/.ssh/github";
		};
	};
	services.syncthing = {
		enable = true;
		tray.enable = true;
	};
	# See #87 for more info on this hack
	systemd.user.targets.tray = {
		Unit = {
			Description = "Home Manager System Tray";
			Requires = [ "graphical-session-pre.target" ];
		};
	};
}
