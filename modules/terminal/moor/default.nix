{...}: {
  flake.homeModules.moor = {pkgs, lib, ...}: {
    home.sessionVariables = {
      PAGER = "${lib.getExe pkgs.moor}";
      MOOR = "--statusbar=bold --no-linenumbers";
    };
    home.packages = with pkgs; [moor];
  };
}
