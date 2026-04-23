{...}: {
  flake.lib = {
    mkConvergentType = pkgs: base:
      base
      // {
        merge = loc: defs: let
          vals = map (d: d.value) defs;
          first = builtins.head vals;
          equal = v:
            if base.name == "package"
            then v.outPath == first.outPath
            else v == first;
        in
          if pkgs.lib.all equal vals
          then first
          else throw "Conflicting definitions for ${pkgs.lib.concatStringsSep "." loc}";
      };
  };
}
