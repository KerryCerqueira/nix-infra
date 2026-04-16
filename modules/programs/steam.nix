{self, ...}: {
  flake.nixosModules = {
    steam = {pkgs, ...}: {
      programs = {
        steam = {
          enable = true;
          remotePlay.openFirewall = true;
          localNetworkGameTransfers.openFirewall = true;
          extraCompatPackages = with pkgs; [
            proton-ge-bin
          ];
        };
      };
      environment = {
        systemPackages = with pkgs; [
          mangohud
        ];
        variables = {
          STEAM_FORCE_DESKTOPUI_SCALING = "2";
        };
      };
    };
    claudius = {imports = [self.nixosModules.steam];};
    napoleon = {imports = [self.nixosModules.steam];};
    panza = {imports = [self.nixosModules.steam];};
    potato = {imports = [self.nixosModules.steam];};
  };
}
