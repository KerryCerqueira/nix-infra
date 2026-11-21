top @ {...}: {
  flake = {
    nixosModules = {
      terminal = {pkgs, ...}: {
        imports = with top.config.flake.nixosModules; [
          zsh
          fish
        ];
        users.defaultUserShell = pkgs.zsh;
      };
      claudius.imports = [top.config.flake.nixosModules.terminal];
      napoleon.imports = [top.config.flake.nixosModules.terminal];
      panza.imports = [top.config.flake.nixosModules.terminal];
      sebastiao.imports = [top.config.flake.nixosModules.terminal];
    };
    homeModules.terminal = {pkgs, ...}: {
      imports = with top.config.flake.homeModules; [
        bat
        btop
        direnv
        eza
        fish
        gh
        moor
        oh-my-posh
        zsh
      ];
      home.packages = with pkgs; [
        git
        fzf
        tldr
        dust
        fd
        ripgrep
        sshfs
        tmux
        timg
        yazi
      ];
    };
    homeModules.kerry.imports = [top.config.flake.homeModules.terminal];
    homeModules.erika.imports = [top.config.flake.homeModules.terminal];
    homeModules.jovianUser.imports = [top.config.flake.homeModules.terminal];
  };
}
