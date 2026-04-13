{self, ...}: {
  flake = {
    lib.wrapperModules.lazy-neovim = {
      pkgs,
      lib,
      wlib,
      config,
      ...
    }: let
      mkConvergentType = self.lib.mkConvergentType pkgs;
    in {
      options = {
        lspConfig = lib.mkOption {
          type = lib.types.attrsOf (lib.types.submodule {
            options = {
              pkg = lib.mkOption {
                type = mkConvergentType lib.types.package;
                description = "Language server derivation.";
              };
              config = lib.mkOption {
                type = lib.types.anything;
                description = "Configuration table passed to vim.lsp.config";
                default = {};
              };
            };
          });
        };
      };
      config = {
        extraPackages =
          lib.mapAttrsToList
          (_name: spec: spec.pkg)
          config.lspConfig;
        info.lsp_config =
          lib.mapAttrs
          (name: value: value.config)
          config.lspConfig;
      };
    };
  };
}
