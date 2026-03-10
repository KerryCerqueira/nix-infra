{
  self,
  inputs,
  ...
}: {
  flake.homeModules.claude-desktop = {
    pkgs,
    lib,
    config,
    ...
  }: {
    home.packages = [
      inputs.claude-desktop.packages.${pkgs.system}.claude-desktop-fhs
    ];
    sops.templates."claude_desktop_config.json" = {
      content = builtins.toJSON {
        mcpServers = {
          arxiv = {
            command = lib.getExe self.packages.${pkgs.system}.arxiv-mcp-server;
            args = ["--storage-path" "${config.xdg.dataHome}/arxiv-mcp-server"];
          };
          nixos = {
            command = lib.getExe pkgs.mcp-nixos;
            args = [];
          };
        };
      };
      path = "${config.xdg.configHome}/Claude/claude_desktop_config.json";
    };
  };
}
