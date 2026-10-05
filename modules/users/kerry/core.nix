{self, ...}: {
  flake = {
    nixosModules = {
      kerry = {config, ...}: {
        users.users.kerry = {
          isNormalUser = true;
          description = "Kerry Cerqueira";
          extraGroups = ["networkmanager" "wheel"];
          hashedPasswordFile =
            config.sops.secrets."hashedPasswords/kerry".path;
        };
        sops.secrets."hashedPasswords/kerry" = {
          sopsFile = ./secrets/hashed-password;
          format = "binary";
          neededForUsers = true;
        };
      };
      claudius.home-manager.users.kerry = self.homeModules.kerry-claudius;
      mushu.home-manager.users.kerry = self.homeModules.kerry-mushu;
      panza.home-manager.users.kerry = self.homeModules.kerry-panza;
      potato.home-manager.users.kerry = self.homeModules.kerry-potato;
      sebastiao.home-manager.users.kerry = self.homeModules.kerry-sebastiao;
    };
    homeModules.kerry = {pkgs, ...}: {
      programs = {
        home-manager.enable = true;
        thunderbird.enable = true;
        chromium.enable = true;
      };
      home.packages = with pkgs; [
        claude-code
        obsidian
        inkscape-with-extensions
        ipe
        gimp
        discord
        slack
        zoom-us
        teams-for-linux
        rnote
        vlc
        spotify
        karere
      ];
    };
  };
  deployments = {
    homeModules.kerry = [
      "kerry-claudius"
      "kerry-mushu"
      "kerry-panza"
      "kerry-potato"
      "kerry-sebastiao"
    ];
    nixosModules.kerry = [
      "kerry-claudius"
      "mushu"
      "panza"
      "potato"
      "sebastiao"
    ];
  };
}
