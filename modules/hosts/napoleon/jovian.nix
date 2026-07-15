{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.napoleon = {
    config,
    pkgs,
    lib,
    ...
  }: {
    imports = [inputs.jovian.nixosModules.jovian];
    jovian = {
      hardware = {
        has.amd.gpu = true;
        amd.gpu.enableBacklightControl = false;
      };
      steam = {
        enable = true;
        autoStart = true;
        user = "steam";
        desktopSession = "gnome";
        environment.STEAM_EXTRA_COMPAT_TOOLS_PATHS =
          lib.makeSearchPathOutput "steamcompattool" "" [pkgs.proton-ge-bin];
      };
    };
    services.displayManager.gdm.enable = false;
    users.users.steam = {
      isNormalUser = true;
      uid = self.lib.constants.uids.steam;
      description = "Living room gaming user";
      extraGroups = ["networkmanager" "wheel"];
      hashedPasswordFile = config.sops.secrets."hashedPasswords/steam".path;
      packages = with pkgs; [
        discord
        slack
        vlc
        spotify
      ];
    };
    programs.firefox.enable = true;
    sops.secrets."hashedPasswords/steam".neededForUsers = true;
  };
}
