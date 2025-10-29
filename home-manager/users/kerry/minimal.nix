{ inputs, ... }:

{
	imports = [
		inputs.nvim-config.homeManagerModules.nvim-config
		inputs.shell-config.homeManagerModules.shell-config
	];
	programs.home-manager.enable = true;
}
