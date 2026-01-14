{self, ...}: {
  flake.nixosModules.napoleon = {config, ...}: {
    users.users.kerry = {
      isNormalUser = true;
      description = "Kerry Cerqueira";
      hashedPasswordFile = config.sops.secrets."hashedUserPasswords/kerry".path;
      extraGroups = ["networkmanager" "wheel"];
    };
    home-manager.users.kerry = {
      imports = [
        self.homeModules."kerry@napoleon"
      ];
    };
  };
  flake.homeModules."kerry@napoleon" = {
    config,
    pkgs,
    ...
  }: {
    imports = [
      self.homeModules.kerry
    ];
    home.stateVersion = "25.11";
  };
}
