{...}: {
  flake.homeModules.eza = {pkgs, ...}: {
    home.packages = with pkgs; [
      eza
    ];
    xdg.configFile."eza/" = {
      source = ./src;
      recursive = true;
    };
  };
}
