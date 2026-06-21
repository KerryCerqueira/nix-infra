{self, ...}: {
  flake.homeModules = {
    mcp = {
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
              command =
                lib.getExe
                self.packages.${pkgs.system}.arxiv-mcp-server;
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
    "kerry@claudius" = {config, ...}: {
      imports = [self.homeModules.mcp];
      sops.secrets."apiKeys/github" = {};
      programs.mcp.servers.github.env = let
        secretPath = config.sops.secrets."apiKeys/github".path;
      in {
        GITHUB_PERSONAL_ACCESS_TOKEN = "{file:${secretPath}}";
      };
    };
    "kerry@sebastiao" = {config, ...}: {
      imports = [self.homeModules.mcp];
      sops.secrets."apiKeys/github" = {};
      programs.mcp.servers.github.env = let
        secretPath = config.sops.secrets."apiKeys/github".path;
      in {
        GITHUB_PERSONAL_ACCESS_TOKEN = "{file:${secretPath}}";
      };
    };
  };
}
