{
  self,
  inputs,
  ...
}: {
  flake.homeModules."kerry@claudius" = {
    pkgs,
    lib,
    config,
    ...
  }: {
    home.packages = [
      inputs.claude-desktop.packages.${pkgs.system}.claude-desktop-fhs
    ];
    sops.secrets."apiKeys/github/claude-code" = {};
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
          github = {
            command = lib.getExe pkgs.github-mcp-server;
            args = ["stdio"];
            env = {
              GITHUB_PERSONAL_ACCESS_TOKEN = config.sops.placeholder."apiKeys/github/claude-code";
            };
          };
        };
      };
      path = "${config.xdg.configHome}/Claude/claude_desktop_config.json";
    };
  };
}
