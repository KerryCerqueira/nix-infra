{
  flake.nixosModules.napoleon = {
    pkgs,
    lib,
    ...
  }: {
    networking.networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-openconnect
      ];
    };
  };
}
