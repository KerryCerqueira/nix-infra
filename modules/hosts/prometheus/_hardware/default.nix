{...}: {
  imports = [
    ./hardware-configuration.nix
    ./sound.nix
  ];
  system.stateVersion = "24.11";
  nixpkgs.config.allowUnfree = true;
  networking.hostName = "prometheus";
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
      then "/etc/age/prometheus.age"
      else envKey;
    secrets = {
      "ageKeys/kerryPrometheus" = {
        path = "/home/kerry/.config/sops/age/keys.txt";
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
      erika = {
        isNormalUser = true;
        description = "Erika Titley";
        extraGroups = ["networkmanager" "wheel"];
      };
    };
  };
}
