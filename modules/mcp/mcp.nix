{self, ...}: {
  flake = {
    nixosModules = {
      claudius.sops.secrets."kerry/apiKeys/github" = {
        owner = "kerry";
        mode = "0400";
      };
      sebastiao.sops.secrets."kerry/apiKeys/github" = {
        owner = "kerry";
        mode = "0400";
      };
    };
    homeModules = {
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
      "kerry@claudius" = {
        osConfig,
        pkgs,
        lib,
        ...
      }: {
        imports = [self.homeModules.mcp];
        programs.mcp.servers.github = {
          args = ["stdio"];
          command = lib.getExe (pkgs.writeShellScriptBin "github-mcp-server-wrapped" ''
            export GITHUB_PERSONAL_ACCESS_TOKEN="$(cat ${osConfig.sops.secrets."kerry/apiKeys/github".path})"
            exec ${lib.getExe pkgs.github-mcp-server} "$@"
          '');
        };
      };
      "kerry@sebastiao" = {
        osConfig,
        pkgs,
        lib,
        ...
      }: {
        imports = [self.homeModules.mcp];
        programs.mcp.servers.github = {
          args = ["stdio"];
          command = lib.getExe (pkgs.writeShellScriptBin "github-mcp-server-wrapped" ''
            export GITHUB_PERSONAL_ACCESS_TOKEN="$(cat ${osConfig.sops.secrets."kerry/apiKeys/github".path})"
            exec ${lib.getExe pkgs.github-mcp-server} "$@"
          '');
        };
      };
    };
  };
}
