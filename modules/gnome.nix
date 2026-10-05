{
  flake.nixosModules.gnome = {
    pkgs,
    lib,
    ...
  }: {
    powerManagement.enable = true;
    services = {
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = lib.mkDefault true;
      xserver.excludePackages = [pkgs.xterm];
      udev.packages = with pkgs; [gnome-settings-daemon];
    };
    environment = {
      gnome.excludePackages = with pkgs; [
        geary
        gnome-tour
        gnome-music
        epiphany
        gnome-calendar
        gnome-console
        gnome-contacts
        gnome-connections
        gnome-music
        totem
      ];
      systemPackages = with pkgs.gnomeExtensions; [
        appindicator
        auto-move-windows
        caffeine
        clipboard-indicator
        paperwm
        places-status-indicator
        launch-new-instance
        removable-drive-menu
        vitals
        impatience
        runcat
        pkgs.wl-clipboard
      ];
    };
    programs = {
      nautilus-open-any-terminal.enable = true;
      dconf.enable = true;
      kdeconnect = {
        enable = true;
        package = pkgs.gnomeExtensions.gsconnect;
      };
    };
  };
  flake.homeModules.gnome = {
    pkgs,
    lib,
    ...
  }: let
    restore = pkgs.writeShellApplication {
      name = "restore-previous-version";
      text = ''
        paths="''${NAUTILUS_SCRIPT_SELECTED_FILE_PATHS:-}"
        target="''${paths%%$'\n'*}"
        if [ -z "$target" ]; then
          target="$PWD"
        elif [ ! -d "$target" ]; then
          target="''${target%/*}"
        fi
        # shellcheck disable=SC2016
        exec xdg-terminal-exec ${pkgs.bash}/bin/bash -c '
          cd "$1" || exit 1
          ${pkgs.httm}/bin/httm -d --copy
          read -rp "Press Enter to close. "
        ' restore "$target"
      '';
    };
  in {
    xdg.dataFile = {
      "nautilus/scripts/Restore previous version".source = lib.getExe restore;
    };
  };
  deployments = {
    nixosModules.gnome = [
      "claudius"
      "mushu"
      "napoleon"
      "panza"
      "potato"
      "sebastiao"
    ];
    homeModules.gnome = ["kerry-claudius"];
  };
}
