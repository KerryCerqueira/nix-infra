{...}: {
  flake.homeModules.ssh = {...}: {
    programs.ssh = {
      enable = true;
      includes = ["~/.ssh/config.d/*.conf"];
      matchBlocks = {
        "*" = {
          identitiesOnly = true;
          serverAliveInterval = 15;
          serverAliveCountMax = 3;
          extraOptions = {
            AddKeysToAgent = "yes";
          };
        };
        "github" = {
          hostname = "github.com";
          user = "git";
        };
      };
    };
  };
}
