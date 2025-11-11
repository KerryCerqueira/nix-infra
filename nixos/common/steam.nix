{...}: {
  flake.nixosModules.steam = {pkgs, ...}: {
    programs = {
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
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
}
