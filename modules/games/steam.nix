{
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
      environment.systemPackages = with pkgs; [mangohud];
    };
    kerry-claudius = {config, ...}: let
      kerry = config.users.users.kerry;
    in {
      systemd.tmpfiles.settings."home-snapshots" = {
        "${kerry.home}/.local/share/Steam/steamapps".v = {
          user = kerry.name;
          group = kerry.group;
          mode = "0700";
        };
      };
    };
  };
  deployments.nixosModules.steam = [
    "claudius"
    "napoleon"
    "panza"
  ];
}
