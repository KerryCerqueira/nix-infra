{inputs, ...}: {
  imports = [
    ./bluetooth.nix
    ./hardware-configuration.nix
    ./sound.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen2
  ];
}
