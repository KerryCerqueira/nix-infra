{inputs, ...}: {
  flake.nixosModules = {
    sops.imports = [inputs.sops-nix.nixosModules.sops];
    sops-stable.imports = [inputs.sops-nix-stable.nixosModules.sops];
  };
  deployments.nixosModules = {
    sops = [
      "claudius"
      "napoleon"
      "panza"
      "potato"
      "sebastiao"
    ];
    sops-stable = ["mushu"];
  };
}
