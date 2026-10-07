{self, ...}: {
  flake = {
    nixosModules = {
      erika.users.users.erika = {
        isNormalUser = true;
        description = "Erika Titley";
        extraGroups = ["networkmanager" "wheel"];
      };
      mushu.home-manager.users.erika = self.homeModules.erika-mushu;
      panza.home-manager.users.erika = self.homeModules.erika-panza;
    };
    homeModules.erika = {pkgs, ...}: {
      programs = {
        home-manager.enable = true;
        chromium.enable = true;
        thunderbird.enable = true;
      };
      home.packages = with pkgs; [
        discord
        zoom-us
        rnote
        vlc
        spotify
        karere
        zotero
      ];
    };
  };
  deployments = {
    nixosModules.erika = [
      "mushu"
      "panza"
    ];
    homeModules.erika = [
      "erika-mushu"
      "erika-panza"
    ];
  };
}
