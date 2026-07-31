{...}: {
  flake.homeModules.erika = {pkgs, ...}: {
    programs = {
      home-manager.enable = true;
      chromium.enable = true;
      thunderbird.enable = true;
    };
    home = {
      packages = with pkgs; [
        discord
        zoom-us
        rnote
        vlc
        spotify
        karere
      ];
    };
  };
}
