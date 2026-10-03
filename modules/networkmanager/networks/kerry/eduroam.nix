{
  flake.nixosModules.kerry = {
    networking.networkmanager.ensureProfiles.profiles."eduroam" = {
      "802-1x" = {
        eap = "peap;";
        identity = "kerrycerqueira@cunet.carleton.ca";
        password = "$EDUROAM";
        phase2-auth = "mschapv2";
        ca-cert = "/etc/ssl/certs/ca-certificates.crt";
        domain-suffix-match = "net.carleton.ca";
      };
      connection = {
        id = "eduroam";
        type = "wifi";
        uuid = "c3879076-cf00-4ac9-a6cb-c01d9e9dacf2";
        permissions = "user:kerry:;";
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
        ssid = "eduroam";
      };
      wifi-security = {
        key-mgmt = "wpa-eap";
      };
    };
  };
}
