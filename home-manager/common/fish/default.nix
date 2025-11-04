{...}: {
  flake.homeModules.fish = {pkgs, ...}: {
    xdg.configFile = {
      "fish/conf.d/" = {
        source = ./src/conf.d;
        recursive = true;
      };
      "fish/functions/" = {
        source = ./src/functions;
        recursive = true;
      };
    };
    programs.fish = {
      enable = true;
      plugins = with pkgs.fishPlugins; [
        {
          name = "fish-you-should-use";
          src = fish-you-should-use.src;
        }
        {
          name = "forgit";
          src = forgit.src;
        }
        {
          name = "fzf-fish";
          src = fzf-fish.src;
        }
        {
          name = "pisces";
          src = pisces.src;
        }
      ];
      interactiveShellInit =
        # fish
        ''
          ${pkgs.any-nix-shell}/bin/any-nix-shell fish | source
        '';
    };
  };
}
