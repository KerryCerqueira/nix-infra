{pkgs, ...}: let
  tex = pkgs.texlive.combine {
    inherit
      (pkgs.texlive)
      preview
      standalone
      varwidth
      scheme-small
      ;
  };
in {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      snacks-nvim
    ];
    extraPackages = with pkgs; [
      ghostscript
      imagemagick
      mermaid-cli
      tex
    ];
  };
  xdg.configFile = {
    "nvim/lua/plugins/ui/snacks-nvim.lua".source =
      ../../src/lua/plugins/ui/snacks-nvim.lua;
  };
}
