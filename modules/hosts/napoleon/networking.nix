{
  flake.nixosModules.napoleon = {
    pkgs,
    lib,
    ...
  }: {
    networking = {
      hostName = "napoleon";
      networkmanager = {
        enable = true;
        plugins = with pkgs; [
          networkmanager-openconnect
        ];
      };
    };
  };
}
