{self, ...}: {
  flake = {
    homeModules = {
      emulation = {
        config,
        lib,
        pkgs,
        ...
      }: let
        contentPath = "${config.xdg.dataHome}/emulation";
        baseSettings = {
          assets_directory = "${pkgs.retroarch-assets}/share/retroarch/assets";
          joypad_autoconfig_dir = "${pkgs.retroarch-joypad-autoconfig}/share/libretro/autoconfig";
          libretro_info_path = "${pkgs.libretro-core-info}/share/retroarch/cores";
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
      jovianUser.imports = [self.homeModules.emulation];
      "kerry@claudius".imports = [self.homeModules.emulation];
    };
    nixosModules.napoleon = {...}: let
      romsPath = "/steam/bulk/emulation-roms";
    in {
      home-manager.users.steam = self.homeModules.jovianUser;
      fileSystems."/home/steam/.local/share/emulation/roms" = {
        device = romsPath;
        fsType = "none";
        options = ["bind"];
      };
    };
  };
}
