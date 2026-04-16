{self, ...}: {
  flake.nixosModules.panza = {config, ...}: {
    imports = [self.nixosModules.kerry];
    users.users.kerry = {
      hashedPasswordFile = config.sops.secrets."hashedUserPasswords/kerry".path;
    };
    home-manager.users.kerry = self.homeModules."kerry@panza";
  };
  flake.homeModules."kerry@panza" = {config, ...}: {
    imports = with self.homeModules; [
      kerry
      easyeffects
    ];
    home.stateVersion = "23.11";
    sops = {
      defaultSopsFile = ./panza_secrets.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = "${config.home.homeDirectory}/.config/sops/age/kerry.age";
      secrets = {
        "syncthing/cert" = {
          path = "${config.home.homeDirectory}/.config/syncthing/cert.pem";
        };
        "syncthing/key" = {
          path = "${config.home.homeDirectory}/.config/syncthing/key.pem";
        };
      };
    };
  };
}
