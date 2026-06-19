{
  flake.homeModules.kerry = {
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        accent-color = "orange";
        clock-format = "12h";
        clock-show-weekday = true;
        color-scheme = "prefer-dark";
        enable-hot-corners = false;
        show-battery-percentage = true;
      };
      "org/gnome/desktop/wm/keybindings" = {
        close = ["<Super>q"];
        maximize = ["<Super>Up"];
        minimize = [];
        move-to-monitor-down = ["<Super><Shift>Down"];
        move-to-monitor-left = ["<Super><Shift>Left"];
        move-to-monitor-right = ["<Super><Shift>Right"];
        move-to-monitor-up = ["<Super><Shift>Up"];
        move-to-workspace-1 = ["<Shift><Super>1"];
        move-to-workspace-2 = ["<Shift><Super>2"];
        move-to-workspace-3 = ["<Shift><Super>3"];
        move-to-workspace-4 = ["<Shift><Super>4"];
        move-to-workspace-down = ["<Control><Shift><Alt>Down"];
        move-to-workspace-left = ["<Super><Shift>Page_Up" "<Super><Shift><Alt>Left" "<Control><Shift><Alt>Left"];
        move-to-workspace-right = ["<Super><Shift>Page_Down" "<Super><Shift><Alt>Right" "<Control><Shift><Alt>Right"];
        move-to-workspace-up = ["<Control><Shift><Alt>Up"];
        panel-run-dialog = ["<Super>r"];
        switch-applications = ["<Super>Tab" "<Alt>Tab"];
        switch-applications-backward = ["<Shift><Super>Tab" "<Shift><Alt>Tab"];
        switch-group = ["<Super>Above_Tab" "<Alt>Above_Tab"];
        switch-group-backward = ["<Shift><Super>Above_Tab" "<Shift><Alt>Above_Tab"];
        switch-panels = ["<Control><Alt>Tab"];
        switch-panels-backward = ["<Shift><Control><Alt>Tab"];
        switch-to-workspace-1 = ["<Super>1"];
        switch-to-workspace-2 = ["<Super>2"];
        switch-to-workspace-3 = ["<Super>3"];
        switch-to-workspace-4 = ["<Super>4"];
        switch-to-workspace-last = ["<Super>End"];
        switch-to-workspace-left = ["<Super>Page_Up" "<Super><Alt>Left" "<Control><Alt>Left"];
        switch-to-workspace-right = ["<Super>Page_Down" "<Super><Alt>Right" "<Control><Alt>Right"];
        toggle-fullscreen = ["<Super>f"];
        unmaximize = ["<Super>Down" "<Alt>F5"];
      };
      "org/gnome/mutter" = {
        attach-modal-dialogs = true;
        dynamic-workspaces = false;
        edge-tiling = true;
        workspaces-only-on-primary = true;
      };
      "org/gnome/mutter/keybindings" = {
        cancel-input-capture = ["<Super><Shift>Escape"];
        toggle-tiled-left = ["<Super>Left"];
        toggle-tiled-right = ["<Super>Right"];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>Return";
        command = "kitty";
        name = "terminal";
      };
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = ["appindicatorsupport@rgcjonas.gmail.com" "caffeine@patapon.info" "clipboard-indicator@tudmotu.com" "gsconnect@andyholmes.github.io" "launch-new-instance@gnome-shell-extensions.gcampax.github.com" "places-menu@gnome-shell-extensions.gcampax.github.com" "drive-menu@gnome-shell-extensions.gcampax.github.com" "runcat@kolesnikov.se" "Vitals@CoreCoding.com" "impatience@gfxmonk.net"];
      };
      "org/gnome/shell/app-switcher" = {
        current-workspace-only = true;
      };
      "org/gnome/shell/extensions/runcat" = {
        idle-threshold = 5;
      };
      "org/gnome/shell/keybindings" = {
        focus-active-notification = [];
        shift-overview-down = ["<Super><Alt>Down"];
        shift-overview-up = ["<Super><Alt>Up"];
        switch-to-application-1 = [];
        switch-to-application-2 = [];
        switch-to-application-3 = [];
        switch-to-application-4 = [];
        toggle-application-view = ["<Super>d"];
        toggle-message-tray = ["<Super>n"];
      };
    };
  };
}
