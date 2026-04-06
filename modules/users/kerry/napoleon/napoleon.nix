{self, ...}: {
  flake.nixosModules.napoleon = {config, ...}: {
    users.users.kerry = {
      isNormalUser = true;
      description = "Kerry Cerqueira";
      extraGroups = ["networkmanager" "wheel"];
      hashedPasswordFile = config.sops.secrets."hashedUserPasswords/kerry".path;
      uid = 1000;
    };
    home-manager.users.kerry = self.homeModules."kerry@napoleon";
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
