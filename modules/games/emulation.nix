{
  flake = {
    homeModules.emulation = {
      config,
      lib,
      pkgs,
      ...
    }: let
      cfg = config.emulation;
      contentPath = "${config.xdg.dataHome}/emulation";
      baseSettings = {
        assets_directory = "${pkgs.retroarch-assets}/share/retroarch/assets";
        joypad_autoconfig_dir = "${pkgs.retroarch-joypad-autoconfig}/share/libretro/autoconfig";
        libretro_info_path = "${pkgs.libretro-core-info}/share/retroarch/cores";
        rgui_browser_directory = cfg.romsPath;
        system_directory = "${contentPath}/bios";
        savefile_directory = "${contentPath}/saves";
        savestate_directory = "${contentPath}/states";
        menu_driver = "ozone";
        video_driver = "vulkan";
        video_fullscreen = "true";
        input_joypad_driver = "sdl2";
      };
      pixelArt = {
        video_scale_integer = "true";
        video_smooth = "false";
      };
      smooth3d = {
        video_scale_integer = "false";
        video_smooth = "true";
      };
      mkSettingsFile = name: extra:
        pkgs.writeText "retroarch-${name}.cfg" (
          lib.concatStringsSep "\n" (lib.mapAttrsToList (k: v: ''${k} = "${v}"'') (baseSettings // extra))
        );
      mkLauncher = {
        name,
        core,
        settings ? {},
      }:
        pkgs.writeShellApplication {
          inherit name;
          text = ''
            unset LD_PRELOAD LD_LIBRARY_PATH

            exec ${lib.getExe core} \
              --appendconfig=${mkSettingsFile name settings} \
              "$@"
          '';
        };
    in {
      options.emulation = {
        enable = lib.mkEnableOption "console emulation launchers";
        romsPath = lib.mkOption {
          type = lib.types.str;
          default = "${contentPath}/roms";
          defaultText = lib.literalExpression ''"''${config.xdg.dataHome}/emulation/roms"'';
          example = "/steam/bulk/emulation-roms";
          description = ''
            Root of the ROM library, one subdirectory per system.

            ROMs are bulky and re-acquirable, unlike the BIOS dumps, saves
            and states, which stay under `$XDG_DATA_HOME/emulation`. Hosts
            with bulk storage point this at it directly, rather than
            mounting that storage into the home directory (#244).
          '';
        };
      };
      config = lib.mkIf cfg.enable {
        home.packages = [
          (mkLauncher {
            name = "emu-nes";
            core = pkgs.libretro.mesen;
            settings = pixelArt;
          })
          (mkLauncher {
            name = "emu-snes";
            core = pkgs.libretro.bsnes;
            settings = pixelArt;
          })
          (mkLauncher {
            name = "emu-gb";
            core = pkgs.libretro.sameboy;
            settings = pixelArt;
          })
          (mkLauncher {
            name = "emu-gba";
            core = pkgs.libretro.mgba;
            settings = pixelArt;
          })
          (mkLauncher {
            name = "emu-ds";
            core = pkgs.libretro.melondsds;
            settings = pixelArt;
          })
          (mkLauncher {
            name = "emu-psx";
            core = pkgs.libretro.swanstation;
            settings = smooth3d;
          })
          pkgs.steam-rom-manager
          (pkgs.retroarch.withCores (_: []))
        ];
      };
    };
    homeModules.kerry-claudius.emulation.enable = true;
    homeModules.jovianUser.emulation = {
      enable = true;
      romsPath = "/steam/bulk/emulation-roms";
    };
    nixosModules.napoleon = {
      systemd.tmpfiles.rules = [
        "d /steam/bulk/emulation-roms 0755 steam users -"
      ];
    };
  };
  deployments.homeModules.emulation = [
    "jovianUser"
    "kerry-claudius"
  ];
}
