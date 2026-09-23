{
  self,
  lib,
  ...
}: {
  flake = {
    nixosModules =
      lib.genAttrs [
        "claudius"
        "sebastiao"
      ]
      (
        _: {imports = [self.nixosModules.mcp];}
      );
    homeModules.mcp = {
      config,
      pkgs,
      lib,
      ...
    }: {
      programs = {
        mcp.enable = true;
        opencode.enableMcpIntegration = true;
      };
    };
  };
  deployments = {
    homeModules.mcp = [
      "kerry-claudius"
      "kerry-sebastiao"
    ];
    nixosModules.mcp = [
      "claudius"
      "sebastiao"
    ];
  };
}
