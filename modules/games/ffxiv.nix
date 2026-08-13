{self, ...}: {
  flake.homeModules = {
    ffxiv = {
      config,
      lib,
      pkgs,
      ...
    }: let
      stableLauncherPath = ".local/bin/xivlauncher-jovian";
      wrapped-launcher = pkgs.writeShellApplication {
        name = "xivlauncher-jovian";
        text = ''
          export XL_USE_STEAM=1
          export XL_APPID=312060
          export XL_DECK=1
          exec ${lib.getExe pkgs.xivlauncher} "$@"
        '';
      };
    in {
      home.packages = [pkgs.xivlauncher wrapped-launcher];
      home.file.${stableLauncherPath}.source = lib.getExe wrapped-launcher;
      xdg.desktopEntries.xivlauncher-jovian = {
        name = "XIVLauncher (Game Mode)";
        exec = "${config.home.homeDirectory}/${stableLauncherPath}";
        icon = "${pkgs.xivlauncher}/share/pixmaps/xivlauncher.png";
        terminal = false;
        categories = ["Game"];
        settings.StartupWMClass = "XIVLauncher.Core";
      };
    };
    jovianUser.imports = [self.homeModules.ffxiv];
    "kerry@claudius".imports = [self.homeModules.ffxiv];
  };
}
