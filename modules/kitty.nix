{
  flake = {
    nixosModules.kitty = {pkgs, ...}: {
      environment = {
        gnome.excludePackages = with pkgs; [
          gnome-terminal
          gnome-console
        ];
        systemPackages = with pkgs; [
          kitty
        ];
      };
      programs.nautilus-open-any-terminal.terminal = "kitty";
      xdg.terminal-exec.settings.default = ["kitty.desktop"];
    };
    homeModules.kitty = {
      pkgs,
      lib,
      ...
    }: {
      programs.kitty = {
        enable = true;
        font = {
          package = pkgs.nerd-fonts.iosevka;
          name = "Iosevka Nerd Font";
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
  };
  deployments = {
    nixosModules.kitty = [
      "claudius"
      "mushu"
      "napoleon"
      "panza"
      "potato"
      "sebastiao"
    ];
    homeModules.kitty = [
      "erika"
      "julie"
      "kerry"
    ];
  };
}
