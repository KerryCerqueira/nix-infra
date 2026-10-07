{
  flake.nixosModules.panza.sops = {lib,...}: {
    age.keyFile = lib.mkForce "/etc/age/panza.age";
  };
}
