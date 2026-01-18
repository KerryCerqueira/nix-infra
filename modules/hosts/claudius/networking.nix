{
  flake.nixosModules.claudius = {
    pkgs,
    lib,
    ...
  }: {
    networking = {
      hostName = "claudius";
      networkmanager = {
        enable = true;
        plugins = with pkgs; [
          networkmanager-openconnect
        ];
      };
    };
  };
}
