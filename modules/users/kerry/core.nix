{...}: {
  flake = {
    nixosModules.kerry = {
      users.users.kerry = {
        isNormalUser = true;
        description = "Kerry Cerqueira";
        extraGroups = ["networkmanager" "wheel"];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMwTe1Ww3BY5CcRxWdNZkDd6V7SOPtgI8SgkF1WAIUs kerry@muncher"
        ];
      };
    };
    homeModules = {
      kerry = {pkgs, ...}: {
        programs = {
          home-manager.enable = true;
          thunderbird.enable = true;
          chromium.enable = true;
          firefox.enable = true;
        };
        home = {
          username = "kerry";
          homeDirectory = "/home/kerry";
          packages = with pkgs; [
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
            wasistlos
          ];
        };
      };
    };
  };
}
