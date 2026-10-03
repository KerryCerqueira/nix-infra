{
  flake.nixosModules.networkmanager = {
    networking.networkmanager.ensureProfiles.profiles."espigueiro" = {
      connection = {
        id = "Espigueiro";
        type = "wifi";
        uuid = "3ea2eda3-d470-4033-b4ab-768caac6163d";
      };
      ipv4 = {
        method = "auto";
      };
      ipv6 = {
        addr-gen-mode = "default";
        method = "auto";
      };
      proxy = {};
      wifi = {
        mode = "infrastructure";
        ssid = "Espigueiro";
      };
      wifi-security = {
        auth-alg = "open";
        key-mgmt = "wpa-psk";
        psk = "$ESPIGUEIRO";
      };
    };
  };
}
