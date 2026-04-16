{self, ...}: {
  flake.homeModules = {
    zathura = {...}: {
      programs.zathura = {
        enable = true;
        extraConfig = builtins.readFile ./src/zathurarc;
      };
    };
    kerry = {imports = [self.homeModules.zathura];};
  };
}
