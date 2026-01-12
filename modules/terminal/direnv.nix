{...}: {
  flake.homeModules.terminal = {pkgs, ...}: {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
