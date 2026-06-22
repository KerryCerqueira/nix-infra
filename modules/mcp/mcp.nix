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
            github = lib.mkDefault {
              args = ["stdio"];
              command = lib.getExe pkgs.github-mcp-server;
            };
          };
        };
        opencode.enableMcpIntegration = true;
      };
    };
    "kerry@claudius" = {config, pkgs, lib, ...}: {
      imports = [self.homeModules.mcp];
      sops.secrets."apiKeys/github" = {};
      programs.mcp.servers.github = {
        args = ["stdio"];
        command = lib.getExe (pkgs.writeShellScriptBin "github-mcp-server-wrapped" ''
          export GITHUB_PERSONAL_ACCESS_TOKEN="$(cat ${config.sops.secrets."apiKeys/github".path})"
          exec ${lib.getExe pkgs.github-mcp-server} "$@"
        '');
      };
    };
    "kerry@sebastiao" = {
      config,
      pkgs,
      lib,
      ...
    }: {
      imports = [self.homeModules.mcp];
      sops.secrets."apiKeys/github" = {};
      programs.mcp.servers.github = {
        args = ["stdio"];
        command = lib.getExe (pkgs.writeShellScriptBin "github-mcp-server-wrapped" ''
          export GITHUB_PERSONAL_ACCESS_TOKEN="$(cat ${config.sops.secrets."apiKeys/github".path})"
          exec ${lib.getExe pkgs.github-mcp-server} "$@"
        '');
      };
    };
  };
}
