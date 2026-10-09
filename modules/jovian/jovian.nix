{inputs, ...}: {
  flake.nixosModules.jovian = {
    pkgs,
    lib,
    ...
  }: {
    imports = [inputs.jovian.nixosModules.jovian];
    jovian.steam = {
      enable = true;
      autoStart = true;
      user = "steam";
      desktopSession = "gnome";
      environment.STEAM_EXTRA_COMPAT_TOOLS_PATHS =
        lib.makeSearchPathOutput "steamcompattool" "" [pkgs.proton-ge-bin];
    };
    services.displayManager.gdm.enable = false;
  };
  flake.nixosModules.napoleon = {
    config,
    pkgs,
    lib,
    ...
  }: {
    jovian = {
      hardware = {
        has.amd.gpu = true;
        amd.gpu.enableBacklightControl = false;
      };
    };
  };
  deployments.nixosModules.jovian = ["napoleon"];
}
