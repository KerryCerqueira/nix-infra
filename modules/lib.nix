{lib, ...}: {
  options.flake.lib = lib.mkOption {
    type = lib.types.submodule {
      freeformType = lib.types.attrsOf lib.types.raw;
      options.constants = lib.mkOption {
        type = lib.types.submodule {
          freeformType = lib.types.attrsOf lib.types.anything;
        };
        default = {};
      };
      options.wrapperModules = lib.mkOption {
        type = lib.types.attrsOf lib.types.deferredModule;
        default = {};
      };
    };
    default = {};
  };
}
