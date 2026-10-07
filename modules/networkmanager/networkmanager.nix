{
  flake.nixosModules = {
    networkmanager = {config, ...}: {
      sops.secrets.nm-env = {
        format = "dotenv";
        sopsFile = ./networks/secrets/nm.env;
        restartUnits = ["NetworkManager-ensure-profiles.service"];
      };
      networking.networkmanager = {
        enable = true;
        ensureProfiles.environmentFiles = [config.sops.secrets.nm-env.path];
      };
    };
    kerry = {config, ...}: {
      sops.secrets.kerry-nm-env = {
        format = "dotenv";
        sopsFile = ./networks/secrets/kerry-nm.env;
        restartUnits = ["NetworkManager-ensure-profiles.service"];
      };
      networking.networkmanager.ensureProfiles.environmentFiles = [
        config.sops.secrets.kerry-nm-env.path
      ];
    };
  };
  deployments.nixosModules.networkmanager = [
    "claudius"
    "mushu"
    "napoleon"
    "panza"
    "sebastiao"
  ];
}
