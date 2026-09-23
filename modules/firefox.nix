{
  flake.homeModules = {
    firefox = {config, ...}: {
      programs.firefox = {
        enable = true;
        configPath = "${config.xdg.configHome}/mozilla/firefox";
      };
    };
  };
  deployments.homeModules.firefox = [
    "kerry"
    "erika"
    "julie"
  ];
}
