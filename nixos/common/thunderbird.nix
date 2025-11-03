{...}: {
  flake.nixosModules.thunderbird = {...}: {
    programs.thunderbird = {
      enable = true;
    };
  };
}
