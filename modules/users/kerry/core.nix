{...}: {
  flake = {
    nixosModules.kerry = {config, ...}: {
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
    homeModules = {
      kerry = {pkgs, ...}: {
        programs = {
          home-manager.enable = true;
          thunderbird.enable = true;
          chromium.enable = true;
        };
        home = {
          username = "kerry";
          homeDirectory = "/home/kerry";
          packages = with pkgs; [
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
    };
  };
}
