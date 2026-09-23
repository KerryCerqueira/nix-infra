{
  flake.nixosModules.steam = {pkgs, ...}: {
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
  deployments.nixosModules.steam = [
    "claudius"
    "napoleon"
    "panza"
    "potato"
  ];
}
