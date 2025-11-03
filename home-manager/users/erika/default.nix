{
  self,
  inputs,
  ...
}: {
  flake.homeModules.erika = {pkgs, ...}: {
    imports = with self.homeModules; [
      kitty
      libreoffice
      inputs.nvim-config.homeManagerModules.nvim-config
      inputs.shell-config.homeManagerModules.shell-config
    ];
    programs = {
      home-manager.enable = true;
      chromium.enable = true;
      firefox.enable = true;
    };
    home = {
      username = "erika";
      homeDirectory = "/home/erika";
      packages = with pkgs; [
        discord
        thunderbird
        zoom-us
        rnote
        vlc
        spotify
        whatsapp-for-linux
      ];
    };
  };
}
