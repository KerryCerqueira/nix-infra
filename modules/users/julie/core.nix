{self, ...}: {
  flake = {
    nixosModules = {
      julie.users.users.julie = {
        isNormalUser = true;
        description = "Julie Quigley";
        extraGroups = ["networkmanager"];
      };
      mushu.home-manager.users.julie = self.homeModules.julie-mushu;
    };
    homeModules.julie = {pkgs, ...}: {
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
      ];
    };
  };
  deployments = {
    nixosModules.julie = ["mushu"];
    homeModules.julie = ["julie-mushu"];
  };
}
