top @ {...}: {
  flake.nixosModules.panza = {pkgs, ...}: {
    boot.plymouth = {
      enable = true;
      theme = "PlymouthTheme-Cat";
      themePackages = let
        inherit (pkgs.stdenv.hostPlatform) system;
      in [top.config.flake.packages.${system}.plymouth-theme-cat];
    };
  };
}
