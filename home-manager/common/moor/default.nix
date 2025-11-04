{...}: {
  flake.homeModules.moor = {pkgs, ...}: {
    home.sessionVariables = {
      PAGER = "${pkgs.moor}/bin/moar";
      MOOR = "--statusbar=bold --no-linenumbers";
    };
    home.packages = with pkgs; [moor];
  };
}
