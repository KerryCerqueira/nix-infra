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
    homeModules = {
      mcp = {
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
      "kerry@claudius" = {imports = [self.homeModules.mcp];};
      "kerry@sebastiao" = {imports = [self.homeModules.mcp];};
    };
  };
}
