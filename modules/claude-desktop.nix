{self, inputs, ...}: {
  flake.homeModules.claude-desktop = {
    pkgs,
    lib,
    config,
    ...
  }: {
    config = {
      home.packages = [
        inputs.claude-desktop.packages.${pkgs.system}.claude-desktop-fhs
      ];
      programs.claude-desktop.mcpServers = {
        arxiv = {
          command = lib.getExe self.packages.${pkgs.system}.arxiv-mcp-server;
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
}
