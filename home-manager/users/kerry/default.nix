{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../common/vscode.nix
    ../common/libreoffice.nix
    ../common/zathura
    ../common/kitty
    inputs.nvim-config.homeManagerModules.nvim-config
    inputs.shell-config.homeManagerModules.shell-config
  ];
  programs = {
    home-manager.enable = true;
    firefox.enable = true;
    obs-studio.enable = true;
    zathura.enable = true;
  };
  home = {
    username = "kerry";
    homeDirectory = "/home/kerry";
    packages = with pkgs; [
      obsidian
      inkscape-with-extensions
      ipe
      keepassxc
      gimp
      discord
      slack
      thunderbird
      zoom-us
      teams-for-linux
      rnote
      vlc
      spotify
      whatsapp-for-linux
    ];
  };
}
