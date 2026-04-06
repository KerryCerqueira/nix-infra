{self, ...}: {
  flake.nixosModules.panza = {config, ...}: {
    users.users.kerry = {
      isNormalUser = true;
      description = "Kerry Cerqueira";
      hashedPasswordFile = config.sops.secrets."hashedUserPasswords/kerry".path;
      extraGroups = ["networkmanager" "wheel"];
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
