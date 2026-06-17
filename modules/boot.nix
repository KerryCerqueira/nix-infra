{self, ...}: {
  flake.nixosModules = {
    boot = {
      pkgs,
      lib,
      ...
    }: {
      boot = {
        loader = {
          systemd-boot = {
            enable = true;
            configurationLimit = 10;
            editor = false;
            consoleMode = "max";
          };
          efi = {
            canTouchEfiVariables = true;
            efiSysMountPoint = "/boot";
          };
          timeout = 0;
        };
        plymouth = {
          enable = true;
          theme = "cuts_alt";
          themePackages = with pkgs; [
            (adi1090x-plymouth-themes.override {
              selected_themes = ["cuts_alt"];
            })
          ];
        };
        kernelParams = [
          "quiet"
          "splash"
          "udev.log_level=3"
          "vt.global_cursor_default=0"
        ];
        consoleLogLevel = 0;
        initrd.verbose = false;
      };
    };
    claudius = {imports = [self.nixosModules.boot];};
    napoleon = {imports = [self.nixosModules.boot];};
    panza = {imports = [self.nixosModules.boot];};
    potato = {imports = [self.nixosModules.boot];};
  };
}
