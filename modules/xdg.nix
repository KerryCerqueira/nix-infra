{
  flake = {
    homeModules.xdg = {
      home.preferXdgDirectories = true;
      nix.assumeXdg = true;
      xdg = {
        enable = true;
        terminal-exec.enable = true;
      };
    };
    nixosModules.xdg = {
      nix.settings.use-xdg-base-directories = true;
      xdg.terminal-exec.enable = true;
    };
  };
  deployments = {
    nixosModules.xdg = ["claudius"];
    homeModules.xdg = ["kerry-claudius"];
  };
}
