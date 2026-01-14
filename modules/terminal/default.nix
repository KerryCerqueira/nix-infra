{self, ...}: {
  flake.nixosModules.terminal = {pkgs, ...}: {
    imports = with self.nixosModules; [
      zsh
      fish
      kitty
    ];
    users.defaultUserShell = pkgs.zsh;
  };
  flake.homeModules.terminal = {pkgs, ...}: {
    imports = with self.homeModules; [
      bat
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
      btop
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
}
