{inputs, ...}: let
  lanzaboote-settings = {lib, ...}: {
    boot = {
      loader.systemd-boot.enable = lib.mkForce false;
      lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
      };
    };
  };
in {
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
          theme = lib.mkDefault "cuts_alt";
          themePackages = lib.mkDefault (with pkgs; [
            (adi1090x-plymouth-themes.override {
              selected_themes = ["cuts_alt"];
            })
          ]);
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
    lanzaboote.imports = [
      lanzaboote-settings
      inputs.lanzaboote.nixosModules.lanzaboote
    ];
    lanzaboote-stable.imports = [
      lanzaboote-settings
      inputs.lanzaboote-stable.nixosModules.lanzaboote
    ];
  };
  deployments.nixosModules = {
    boot = [
      "panza"
      "lanzaboote"
    ];
    lanzaboote = [
      "claudius"
      "mushu"
      "napoleon"
      "sebastiao"
    ];
  };
}
