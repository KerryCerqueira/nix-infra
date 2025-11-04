{...}: {
  flake.homeModules.oh-my-posh = {
    programs.oh-my-posh = {
      enable = true;
      settings = builtins.fromJSON (
        builtins.readFile ./src/config.json
      );
    };
  };
}
