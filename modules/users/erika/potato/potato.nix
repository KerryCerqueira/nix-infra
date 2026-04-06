{self, ...}: {
  flake.nixosModules.potato = {...}: {
    users.users.erika = {
      isNormalUser = true;
      description = "Erika";
      extraGroups = ["networkmanager" "wheel"];
    };
    home-manager.users.erika = self.homeModules."erika@potato";
  };
  flake.homeModules."erika@potato" = {...}: {
    home.stateVersion = "23.11";
    sops = {
      defaultSopsFile = ./secrets.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = "/home/erika/.config/sops/age/erika_master.age";
      secrets = {
        "syncthing/cert" = {
          path = "/home/erika/.config/syncthing/cert.pem";
        };
        "syncthing/key" = {
          path = "/home/erika/.config/syncthing/key.pem";
        };
      };
    };
  };
}
