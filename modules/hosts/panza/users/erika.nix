{self, ...}: {
  flake.nixosModules.hosts.panza = {config, ...}: {
    users.users.erika = {
      isNormalUser = true;
      description = "Erika Titley";
      extraGroups = ["networkmanager" "wheel"];
    };
  };
  flake.homeModules."erika@panza" = {
    imports = with self.homeModules; [
      erika
      easyeffects
    ];
    home.stateVersion = "23.11";
  };
}
