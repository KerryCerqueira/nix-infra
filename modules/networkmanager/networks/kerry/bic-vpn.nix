{
  flake.nixosModules.kerry = {
    networking.networkmanager.ensureProfiles.profiles."BIC VPN" = {
      connection = {
        autoconnect = "false";
        id = "BIC VPN";
        type = "vpn";
        uuid = "9f1b9142-1670-49f8-a3fe-11e6521ccffd";
      };
      ipv4 = {
        method = "auto";
      };
      ipv6 = {
        addr-gen-mode = "default";
        method = "auto";
      };
      proxy = {};
      vpn = {
        authtype = "password";
        autoconnect-flags = "0";
        certsigs-flags = "0";
        cookie-flags = "2";
        disable_udp = "no";
        enable_csd_trojan = "no";
        gateway = "https://vpn.bic.theroyal.ca/portal:prelogin-cookie";
        gateway-flags = "2";
        gwcert-flags = "2";
        lasthost-flags = "0";
        pem_passphrase_fsid = "no";
        prevent_invalid_cert = "no";
        protocol = "gp";
        resolve-flags = "2";
        service-type = "org.freedesktop.NetworkManager.openconnect";
        stoken_source = "disabled";
        xmlconfig-flags = "0";
      };
    };
  };
}
