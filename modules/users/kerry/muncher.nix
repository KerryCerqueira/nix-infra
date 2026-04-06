{
  self,
  ...
}: {
  flake = {
    homeModules = {
      "kerry@muncher" = {
        imports = with self.homeModules; [
          neovim
          terminal
        ];
        nixpkgs.config.allowUnfree = true;
        programs.home-manager.enable = true;
        home = {
          stateVersion = "25.11";
          username = "kerry";
          homeDirectory = "/home/kerry";
        };
      };
    };
  };
}
