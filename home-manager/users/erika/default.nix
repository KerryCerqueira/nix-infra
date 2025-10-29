{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../common/vscode.nix
    ../common/libreoffice.nix
    inputs.nvim-config.homeManagerModules.nvim-config
    inputs.shell-config.homeManagerModules.shell-config
  ];
  programs = {
    home-manager.enable = true;
    chromium.enable = true;
    firefox.enable = true;
  };
  services.syncthing = {
    enable = true;
    tray.enable = true;
    tray.command = "syncthingtray --wait";
  };
  home = {
    username = "erika";
    homeDirectory = "/home/erika";
    packages = with pkgs; [
      keepassxc
      gimp
      discord
      thunderbird
      zoom-us
      rnote
      vlc
      spotify
      whatsapp-for-linux
    ];
  };
}
