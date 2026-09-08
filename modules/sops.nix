{
  inputs,
  lib,
  ...
}: {
  flake.nixosModules.sops = lib.gebAttrs [
    "claudius"
    "napoleon"
    "panza"
    "potato"
    "sebastiao"
  ] (_: {config, ...}: {imports = [inputs.sops-nix.nixosModules.sops];});
}
