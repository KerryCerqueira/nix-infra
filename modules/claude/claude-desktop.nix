{
  self,
  inputs,
  ...
}: {
  flake.homeModules = {
    claude-desktop = {
      pkgs,
      lib,
      config,
      ...
    }: let
      inherit (pkgs.stdenv.hostPlatform) system;
      claude-desktop = inputs.claude-desktop.packages.${system}.default;
      claude-desktop-exe = lib.getExe claude-desktop;
      kbPath =
        "org/gnome/settings-daemon/plugins/media-keys/"
        + "custom-keybindings/claude-desktop";
    in {
      home.packages = [claude-desktop];
      xdg.configFile."Claude/claude_desktop_config.json".text = builtins.toJSON {
        mcpServers = config.programs.mcp.servers;
      };
      dconf.settings = {
        ${kbPath} = {
          name = "Claude Desktop";
          binding = "<Control><Alt>space";
          command = "${claude-desktop-exe} --toggle";
        };
        "org/gnome/settings-daemon/plugins/media-keys".custom-keybindings = [
          "/${kbPath}/"
        ];
      };
    };
    "kerry@claudius" = {
      imports = [self.homeModules.claude-desktop];
    };
    "kerry@sebastiao" = {
      imports = [self.homeModules.claude-desktop];
    };
  };
}
