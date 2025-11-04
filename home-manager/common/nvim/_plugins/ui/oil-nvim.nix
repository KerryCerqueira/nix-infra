{pkgs, ...}: let
  oil-git-nvim = let
    commitDate = "2025-09-02T21:44:24-04:00";
    version = "unstable-" + commitDate;
    rev = "d1f27a5982df35b70fb842aa6bbfac10735c7265";
    hash = "sha256-QQj3ck+5GpA/htG0tZzniS5bbfRscvcfXjMUjY8F9A4=";
  in
    pkgs.vimUtils.buildVimPlugin {
      pname = "oil-git.nvim";
      inherit version;
      src = pkgs.fetchFromGitHub {
        owner = "benomahony";
        repo = "oil-git.nvim";
        inherit rev hash;
      };
    };
  oil-lsp-diagnostics-nvim = let
    commitDate = "2025-01-22T08:03:14-06:00";
    version = "unstable-" + commitDate;
    rev = "e04e3c387262b958fee75382f8ff66eae9d037f4";
    hash = "sha256-E8jukH3I8XDdgrG4XHCo9AuFbY0sLX24pjk054xmB9E=";
  in
    pkgs.vimUtils.buildVimPlugin {
      pname = "oil-lsp-diagnostics.nvim";
      inherit version;
      src = pkgs.fetchFromGitHub {
        owner = "JezerM";
        repo = "oil-lsp-diagnostics.nvim";
        inherit rev hash;
      };
      doCheck = false;
    };
in {
  programs.neovim = {
    lazyNixCompat.idOverrides = {
      "oil.nvim" = "stevearc/oil.nvim";
    };
    plugins = with pkgs.vimPlugins; [
      mini-icons
      oil-nvim
      oil-git-nvim
      oil-lsp-diagnostics-nvim
    ];
  };
  xdg.configFile."nvim/lua/plugins/ui/oil-nvim.lua".source =
    ../../src/lua/plugins/ui/oil-nvim.lua;
}
