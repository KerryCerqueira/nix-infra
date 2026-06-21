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
      sops.templates."claude_desktop_config.json" = {
        content = builtins.toJSON {
          mcpServers = config.programs.mcp.servers;
        };
        path = "${config.xdg.configHome}/Claude/claude_desktop_config.json";
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
