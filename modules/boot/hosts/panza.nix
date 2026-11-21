{moduleWithSystem, ...}: {
  flake.nixosModules.panza = moduleWithSystem (
    perSystem @ {config}: {...}: {
      boot.plymouth = {
        enable = true;
        theme = "PlymouthTheme-Cat";
        themePackages = [
          perSystem.config.packages.plymouth-theme-cat
        ];
      };
    }
  );
}
