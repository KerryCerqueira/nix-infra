{self, ...}: {
  flake.nixosModules.hosts.panza = {config, ...}: {
    users.users.kerry = {
      isNormalUser = true;
      description = "Kerry Cerqueira";
      hashedPasswordFile = config.sops.secrets."hashedUserPasswords/kerry".path;
      extraGroups = ["networkmanager" "wheel"];
    };
    home-manager.users.kerry = self.homeModules."kerry@panza";
  };
  flake.homeModules."kerry@panza" = {
    imports = with self.homeModules; [
      kerry
      easyeffects
    ];
    home.stateVersion = "23.11";
  };
}
