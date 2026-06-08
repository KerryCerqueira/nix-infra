{self, ...}: {
  flake = {
    nixosModules = {
      terminal = {pkgs, ...}: {
        imports = with self.nixosModules; [
          zsh
          fish
          kitty
        ];
        users.defaultUserShell = pkgs.zsh;
      };
      claudius = {imports = [self.nixosModules.terminal];};
      napoleon = {imports = [self.nixosModules.terminal];};
      panza = {imports = [self.nixosModules.terminal];};
      potato = {imports = [self.nixosModules.terminal];};
      sebastiao = {imports = [self.nixosModules.terminal];};
    };
    homeModules.terminal = {pkgs, ...}: {
      imports = with self.homeModules; [
        bat
        btop
        direnv
        eza
        fish
        gh
        kitty
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
    homeModules.kerry = {imports = [self.homeModules.terminal];};
    homeModules.erika = {imports = [self.homeModules.terminal];};
  };
}
