{
  flake.nixosModules.claudius = {...}: {
    boot.kernelModules = ["kvm-amd"];
  };
}
