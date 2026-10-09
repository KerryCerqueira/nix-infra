{inputs, ...}: {
  flake.nixosModules.filesystem = {config, ...}: {
    imports = [inputs.disko.nixosModules.disko];
    assertions = [
      {
        assertion = config.boot.initrd.systemd.enable;
        message = "${config.networking.hostName}: TPM2 crypttab options require systemd stage-1 (boot.initrd.systemd.enable = true)";
      }
    ];
  };
  deployments.nixosModules.filesystem = [
    "claudius"
    "mushu"
    "napoleon"
    "sebastiao"
  ];
}
