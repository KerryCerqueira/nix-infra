{self, ...}: {
  flake.nixosModules.jovianUser = {
    config,
    pkgs,
    lib,
    ...
  }: {
    home-manager.users.steam = self.homeModules.jovianUser;
    users.users.steam = {
      isNormalUser = true;
      uid = self.lib.constants.uids.steam;
      description = "Living room gaming user";
      extraGroups = ["networkmanager" "wheel"];
      hashedPasswordFile = config.sops.secrets."hashedPasswords/steam".path;
      packages = with pkgs; [
        discord
        vlc
        spotify
      ];
    };
    programs.firefox.enable = true;
    sops.secrets."hashedPasswords/steam" = {
      sopsFile = ./secrets/hashed-password;
      format = "binary";
      neededForUsers = true;
    };
  };
  deployments.nixosModules.jovianUser = ["napoleon"];
}
