{self, ...}: {
  flake.homeModules = {
    firefox = {config, ...}: {
      programs.firefox = {
        enable = true;
        configPath = "${config.xdg.configHome}/mozilla/firefox";
      };
    };
    kerry = {imports = [self.homeModules.firefox];};
    erika = {imports = [self.homeModules.firefox];};
  };
}
