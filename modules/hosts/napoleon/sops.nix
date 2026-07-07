{inputs, ...}: {
  flake.nixosModules.napoleon = {
    config,
    pkgs,
    ...
  }: {
    imports = [inputs.sops-nix.nixosModules.sops];
    sops = {
      defaultSopsFile = ./secrets.yaml;
      defaultSopsFormat = "yaml";
      age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    };
  };
}
