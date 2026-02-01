{
  flake.homeModules.gh = {pkgs, ...}: {
    programs.gh = {
      enable = true;
      extensions = with pkgs; [
        gh-dash
      ];
    };
  };
}
