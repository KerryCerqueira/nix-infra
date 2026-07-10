{
  flake.homeModules.mcp = {
    config,
    pkgs,
    lib,
    ...
  }: {
    programs.mcp.servers.nixos = {
      args = [];
      command = lib.getExe pkgs.mcp-nixos;
    };
  };
}
