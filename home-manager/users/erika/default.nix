{self, ...}: {
  flake.homeModules.erika = {pkgs, ...}: {
    imports = with self.homeModules; [
      kitty
      libreoffice
      nvim
      shell
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
        wasistlos
      ];
    };
  };
}
