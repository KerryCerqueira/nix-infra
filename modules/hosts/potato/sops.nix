{
  flake.nixosModules.potato.sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/etc/age/potato.age";
  };
}
