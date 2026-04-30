{self, ...}: {
  flake.homeModules.mcp = {
    config,
    pkgs,
    lib,
    ...
  }: {
    programs = {
      mcp = {
        enable = true;
        servers = {
          arxiv = {
            command = lib.getExe self.packages.${pkgs.system}.arxiv-mcp-server;
            args = ["--storage-path" "${config.xdg.dataHome}/arxiv-mcp-server"];
          };
          nixos = {
            args = [];
            command = lib.getExe pkgs.mcp-nixos;
          };
          github = {
            args = ["stdio"];
            command = lib.getExe pkgs.github-mcp-server;
          };
        };
      };
      opencode.enableMcpIntegration = true;
    };
  };
}
