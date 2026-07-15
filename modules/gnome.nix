{self, ...}: {
  flake.nixosModules = {
    gnome = {pkgs, lib, ...}: {
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
        dconf.enable = true;
        kdeconnect = {
          enable = true;
          package = pkgs.gnomeExtensions.gsconnect;
        };
      };
      networking.networkmanager.plugins = with pkgs; [
        networkmanager-openconnect
      ];
    };
    claudius = {imports = [self.nixosModules.gnome];};
    napoleon = {imports = [self.nixosModules.gnome];};
    panza = {imports = [self.nixosModules.gnome];};
    potato = {imports = [self.nixosModules.gnome];};
    sebastiao = {imports = [self.nixosModules.gnome];};
  };
}
