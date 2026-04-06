{self, ...}: {
  flake.nixosModules.potato = {...}: {
    users.users.kerry = {
      isNormalUser = true;
      description = "Kerry Cerqueira";
      extraGroups = ["networkmanager" "wheel"];
    };
    home-manager.users.kerry = self.homeModules."kerry@potato";
  };
  flake.homeModules."kerry@potato" = {...}: {
    imports = [self.homeModules.kerry];
    home.stateVersion = "23.11";
    sops = {
      defaultSopsFile = ./potato_secrets.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = "/home/kerry/.config/sops/age/kerry_potato.age";
      secrets = {
        "syncthing/cert".path = "/home/kerry/.config/syncthing/cert.pem";
        "syncthing/key".path = "/home/kerry/.config/syncthing/key.pem";
        "ssh/github/private".path = "/home/kerry/.ssh/github";
      };
    };
  };
}
