{self, ...}: {
  flake.homeModules = {
    libreoffice = {pkgs, ...}: {
      home.packages = with pkgs; [
        libreoffice
        hunspell
        hunspellDicts.en_CA
        hunspellDicts.fr-any
        hunspellDicts.pt_PT
      ];
    };
    kerry = {imports = [self.homeModules.libreoffice];};
    erika = {imports = [self.homeModules.libreoffice];};
  };
}
