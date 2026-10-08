{
  self,
  inputs,
  ...
}: let
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
    napoleon = {
      pkgs,
      lib,
      ...
    }: {
      boot.plymouth = {
        theme = "colorful_loop";
        themePackages = lib.mkDefault (with pkgs; [
          (adi1090x-plymouth-themes.override {
            selected_themes = ["colorful_loop"];
          })
        ]);
      };
    };
    panza = {pkgs, ...}: {
      boot.plymouth = {
        enable = true;
        theme = "PlymouthTheme-Cat";
        themePackages = let
          inherit (pkgs.stdenv.hostPlatform) system;
        in [self.packages.${system}.plymouth-theme-cat];
      };
    };
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
