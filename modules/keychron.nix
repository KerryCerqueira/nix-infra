{
  flake = {
    nixosModules.keychron.hardware.keyboard.qmk = {
      enable = true;
      keychronSupport = true;
    };
  };
  deployments.nixosModules.keychron = ["napoleon"];
}
