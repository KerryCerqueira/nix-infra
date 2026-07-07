{inputs, ...}: {
  flake.nixosModules.panza = {
    imports = [inputs.sops-nix.nixosModules.sops];
    sops = {
      defaultSopsFile = ./secrets.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = "/etc/age/panza.age";
    };
  };
}
