{ pkgs, ... }:

{
	home.packages = with pkgs; [
		libreoffice
		hunspell
		hunspellDicts.en_CA
		hunspellDicts.fr-any
		hunspellDicts.pt_PT
	];
}
