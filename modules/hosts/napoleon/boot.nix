{
  flake.nixosModules.napoleon = {...}: {
    boot.initrd.kernelModules = [ "amdgpu" ];
    boot.kernelModules = [ "k10temp" "nct6775" ];
  };
}
