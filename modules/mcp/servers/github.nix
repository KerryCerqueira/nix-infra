{...}: {
  flake = {
    nixosModules.mcp = {
      sops.secrets."mcp/github" = {
        sopsFile = ./secrets/github.key;
        format = "binary";
        owner = "kerry";
        mode = "0400";
      };
    };
    homeModules.mcp = {
      osConfig,
      pkgs,
      lib,
      ...
    }: {
      programs.mcp.servers.github = {
        args = ["stdio"];
        command = let
          keyPath = osConfig.sops.secrets."mcp/github".path;
        in
          lib.getExe
          (
            pkgs.writeShellScriptBin
            "github-mcp-server-wrapped"
            ''
              export GITHUB_PERSONAL_ACCESS_TOKEN="$(cat ${keyPath})"
              exec ${lib.getExe pkgs.github-mcp-server} "$@"
            ''
          );
      };
    };
  };
}
