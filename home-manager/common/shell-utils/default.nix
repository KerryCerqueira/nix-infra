{self, ...}: {
  flake.homeModules.shell-utils = {pkgs, ...}: {
    imports = with self.homeModules; [
      bat
      eza
      moor
      oh-my-posh
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
