{self, ...}: {
  flake.nixosModules.hosts.panza = {config, ...}: {
    users.users.erika = {
      isNormalUser = true;
      description = "Erika Titley";
      extraGroups = ["networkmanager" "wheel"];
    };
    home-manager.users.erika = self.homeModules."erika@panza";
  };
  flake.homeModules."erika@panza" = {
    imports = with self.homeModules; [
      erika
      easyeffects
    ];
    home.stateVersion = "23.11";
  };
}
