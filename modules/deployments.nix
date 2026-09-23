{
  self,
  lib,
  config,
  ...
}: let
  namespaces = ["nixosModules" "homeModules"];
in {
  options.deployments = lib.genAttrs namespaces (ns:
    lib.mkOption {
      type = lib.types.attrsOf (lib.types.listOf lib.types.str);
      default = {};
      example = lib.literalExpression ''
        {
          foo = [ "bar" "baz" ];
        }
      '';
      description = ''
        Deployments of modules in `self.${ns}` to other modules in `self.${ns}`.

        Each attribute name is the name of a module in `self.${ns}`, and its
        value is the list of modules in `self.${ns}` that import it.

        Definitions from multiple files are merged: target lists for the same
        module are concatenated, so a module may be deployed from anywhere in
        the flake.
      '';
    });
  config.flake = lib.genAttrs namespaces (ns:
    lib.mkMerge (lib.mapAttrsToList
      (name: modules: lib.genAttrs modules (_: self.${ns}.${name}))
      config.deployments.${ns}));
}
