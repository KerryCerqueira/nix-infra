{...}: {
  flake.nixosModules.zsh = {
    programs.zsh.enable = true;
  };
  flake.homeModules.zsh = {
    pkgs,
    config,
    ...
  }: {
    xdg.configFile."zsh/conf.d/" = {
      source = ./src/conf.d;
      recursive = true;
    };
    programs.zsh = {
      enable = true;
      dotDir = builtins.toPath "${config.xdg.configHome}/zsh";
      antidote = {
        enable = true;
        plugins = let
          splitString = pkgs.lib.strings.splitString;
          pluginsText = builtins.readFile ./src/zsh_plugins.conf;
          zshPlugins = splitString "\n" pluginsText;
        in
          zshPlugins;
      };
      initContent =
        # sh
        ''
          if [[ $(ps -o command= -p "$PPID" | awk '{print $1}') != 'fish' ]]
          then
          exec fish -l
          else
          ${pkgs.any-nix-shell} zsh | source /dev/stdin
          source "$ZDOTDIR"/conf.d/conf.zsh
          fi
        '';
    };
  };
}
