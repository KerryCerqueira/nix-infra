{ pkgs, ... }:
{
	catppuccin.kitty.enable = true;
	programs.kitty = {
		enable = true;
		font = {
			package = pkgs.nerd-fonts.iosevka;
			name = "Iosevka Nerd Font";
		};
		settings = {
			hide_window_decorations = true;
			enable_audio_bell = false;
			visual_bell_duration = 0.1;
			cursor_trail = 1;
			scrollback_pager = "moar --statusbar=bold --no-linenumbers";
			background_opacity = 0.90;
		};
		extraConfig = ''
			include ./extra.conf
		'';
	};
}
