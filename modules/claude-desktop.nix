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
      inherit (inputs.claude-desktop.packages.${system}) claude-desktop-fhs;
      inherit (self.packages.${system}) arxiv-mcp-server;
    in {
      config = {
        home.packages = [claude-desktop-fhs];
        sops.templates."claude_desktop_config.json" = {
          content = builtins.toJSON {
            mcpServers = config.programs.claude-desktop.mcpServers;
          };
          path = "${config.xdg.configHome}/Claude/claude_desktop_config.json";
        };
        programs.claude-desktop.mcpServers = {
          arxiv = {
            command = lib.getExe arxiv-mcp-server;
            args = ["--storage-path" "${config.xdg.dataHome}/arxiv-mcp-server"];
          };
          nixos = {
            command = lib.getExe pkgs.mcp-nixos;
            args = [];
          };
          github = {
            command = lib.getExe pkgs.github-mcp-server;
            args = ["stdio"];
          };
        };
      };
      options.programs.claude-desktop.mcpServers = lib.mkOption {
        type = lib.types.attrsOf lib.types.anything;
        default = {};
        description = "MCP server declarations merged into claude_desktop_config.json.";
      };
    };
    kerry = {imports = [self.homeModules.claude-desktop];};
  };
}
