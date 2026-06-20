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
    claudius = {imports = [self.nixosModules.boot];};
    napoleon = {imports = [self.nixosModules.boot];};
    panza = {pkgs, ...}: {
      imports = [self.nixosModules.boot];
      boot.plymouth = {
        enable = true;
        theme = "PlymouthTheme-Cat";
        themePackages = let
          inherit (pkgs.stdenv.hostPlatform) system;
        in [self.packages.${system}.plymouth-theme-cat];
      };
    };
    potato = {imports = [self.nixosModules.boot];};
    sebastiao = {imports = [self.nixosModules.boot];};
  };
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.plymouth-theme-cat = pkgs.stdenvNoCC.mkDerivation {
      pname = "plymouth-theme-cat";
      version = "0-unstable-2025-01-09";

      src = pkgs.fetchFromGitHub {
        owner = "krishnan793";
        repo = "PlymouthTheme-Cat";
        rev = "9f9bbc0e6cb8677684d198eb1139d90aceff82e0";
        hash = "sha256-yNryZkjSDFYGTExCz6Dkoust749QK65JYoCIO2oN+Y4=";
      };

      dontConfigure = true;
      dontBuild = true;

      installPhase = ''
        runHook preInstall

        mkdir -p $out/share/plymouth/themes/PlymouthTheme-Cat
        cp -r ./* $out/share/plymouth/themes/PlymouthTheme-Cat/

        find $out/share/plymouth/themes/ -name '*.plymouth' \
          -exec sed -i "s@/usr/@$out/@" {} \;

        runHook postInstall
      '';

      meta = {
        description = "Cat animation Plymouth boot splash theme";
        homepage = "https://github.com/krishnan793/PlymouthTheme-Cat";
        license = lib.licenses.gpl3Only;
        platforms = lib.platforms.linux;
      };
    };
  };
}
