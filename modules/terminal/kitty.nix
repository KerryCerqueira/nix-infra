{inputs, ...}: {
  flake.nixosModules.kitty = {pkgs, ...}: {
    environment = {
      gnome.excludePackages = with pkgs; [
        gnome-terminal
      ];
      systemPackages = with pkgs; [
        kitty
      ];
    };
  };
  flake.homeModules.kitty = {pkgs, lib, ...}: {
    programs.kitty = {
      enable = true;
      font = {
        package = pkgs.iosevka;
        name = "Iosevka";
      };
      settings = {
        hide_window_decorations = true;
        enable_audio_bell = false;
        visual_bell_duration = 0.1;
        cursor_trail = 1;
        scrollback_pager = "${lib.getExe pkgs.moor} --statusbar=bold --no-linenumbers";
        background_opacity = 0.90;
      };
      extraConfig =
        # kitty
        ''
          include ./extra.conf
        '';
    };
  };
}
