{...}: {
  imports = [
    ./hardware-configuration.nix
    ./sound.nix
  ];
  system.stateVersion = "24.11";
  nixpkgs.config.allowUnfree = true;
  networking.hostName = "claudius";
  networking.networkmanager.enable = true;
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";
  sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = let
      envKey = builtins.getEnv "SOPS_AGE_KEY_FILE";
    in
      if envKey == ""
      then "/etc/age/claudius.age"
      else envKey;
    secrets = {
      "ageKeys/kerryMaster" = {
        path = "/home/kerry/.config/sops/age/kerry_master.age";
        owner = "kerry";
      };
      "ageKeys/kerryPotato" = {
        path = "/home/kerry/.config/sops/age/kerry_potato.age";
        owner = "kerry";
      };
      "ageKeys/kerryLazarus" = {
        path = "/home/kerry/.config/sops/age/kerry_lazarus.age";
        owner = "kerry";
      };
      "ageKeys/kerryClaudius" = {
        path = "/home/kerry/.config/sops/age/kerry_claudius.age";
        owner = "kerry";
      };
    };
  };
  services = {
    displayManager.gdm.enable = true;
    xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.variant = "";
    };
    fwupd.enable = true;
    printing.enable = true;
  };
  users = {
    users = {
      kerry = {
        isNormalUser = true;
        description = "Kerry Cerqueira";
        extraGroups = ["networkmanager" "wheel"];
      };
    };
  };
}
