{inputs, ...}: let
  sops-common = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
  };
in {
  flake.nixosModules = {
    sops.imports = [
      sops-common
      inputs.sops-nix.nixosModules.sops
    ];
    sops-stable.imports = [
      sops-common
      inputs.sops-nix-stable.nixosModules.sops
    ];
  };
  deployments.nixosModules = {
    sops = [
      "claudius"
      "napoleon"
      "panza"
      "sebastiao"
    ];
    sops-stable = ["mushu"];
  };
}
