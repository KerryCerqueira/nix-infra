{...}: {
  imports = [
    ./gpu.nix
    ./hardware-configuration.nix
    ./sound.nix
  ];
  system.stateVersion = "24.11";
  nixpkgs.config.allowUnfree = true;
  networking.hostName = "sigmund";
  networking.networkmanager.enable = true;
  sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = let
      envKey = builtins.getEnv "SOPS_AGE_KEY_FILE";
    in
      if envKey == ""
      then "/etc/age/sigmund.age"
      else envKey;
    secrets = {
      "ageKeys/kerrySigmund" = {
        path = "/home/kerry/.config/sops/age/kerry_sigmund.age";
        owner = "kerry";
      };
    };
  };
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";
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
