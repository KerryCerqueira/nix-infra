{ pkgs, ...}:

{
	programs = {
		zsh.enable = true;
		fish.enable = true;
		neovim = {
			enable = true;
			defaultEditor = true;
		};
	};
	users.defaultUserShell = pkgs.zsh;
}
