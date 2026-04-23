{lib, ...}: {
  options.flake.mcp.pythonOverrides = lib.mkOption {
    type = lib.types.listOf lib.types.raw;
    default = [];
  };
}
