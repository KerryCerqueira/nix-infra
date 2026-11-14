{inputs, ...}: {
  flake.nixosModules = {
    filesystem.imports = [inputs.disko.nixosModules.disko];
    mushu = {config, ...}: {
      imports = [inputs.disko-stable.nixosModules.disko];
    };
  };
  deployments.nixosModules.filesystem = [
    "claudius"
    "napoleon"
    "sebastiao"
    "panza"
  ];
}
