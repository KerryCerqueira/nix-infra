{
  flake.nixosModules.panza.sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/etc/age/panza.age";
  };
}
