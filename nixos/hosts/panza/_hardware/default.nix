{
  config,
  lib,
  ...
}: {
  imports = [
    ./gpu.nix
    ./hardware-configuration.nix
    ./sound.nix
  ];
  system.stateVersion = "23.11";
  networking.hostName = "panza";
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
      then "/etc/age/panza.age"
      else envKey;
    secrets = {
      "hashedUserPasswords/kerry".neededForUsers = true;
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
  hardware = {
    trackpoint.enable = lib.mkDefault true;
    trackpoint.emulateWheel = lib.mkDefault config.hardware.trackpoint.enable;
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    sensor.iio.enable = true;
  };
  security.rtkit.enable = true;
  services = {
    displayManager.gdm.enable = true;
    xserver = {
      wacom.enable = lib.mkDefault config.services.xserver.enable;
      enable = true;
      xkb.layout = "us";
      xkb.variant = "";
    };
    fwupd.enable = true;
    fprintd.enable = true;
    printing.enable = true;
  };
  users = {
    users = {
      kerry = {
        isNormalUser = true;
        description = "Kerry Cerqueira";
        hashedPasswordFile = config.sops.secrets."hashedUserPasswords/kerry".path;
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
