{self, ...}: {
  flake.nixosModules.terminal = {pkgs, ...}: {
    programs = {
      zsh.enable = true;
      fish.enable = true;
      neovim = {
        enable = true;
        defaultEditor = true;
      };
    };
    users.defaultUserShell = pkgs.zsh;
  };
  flake.homeModules.terminal = {pkgs, ...}: {
    imports = with self.homeModules; [
      bat
      eza
      fish
      kitty
      moor
      nvim
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
    programs = {
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
      gh = {
        enable = true;
        extensions = with pkgs; [
          gh-dash
          gh-copilot
        ];
      };
    };
  };
}
