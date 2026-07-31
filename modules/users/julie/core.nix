{...}: {
  flake.homeModules.julie= {pkgs, ...}: {
    programs = {
      home-manager.enable = true;
      chromium.enable = true;
      firefox.enable = true;
      thunderbird.enable = true;
    };
    home = {
      packages = with pkgs; [
        discord
        zoom-us
        rnote
        vlc
        spotify
      ];
    };
  };
}
