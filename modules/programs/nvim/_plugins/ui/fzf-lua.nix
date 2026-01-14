{pkgs, ...}: {
  programs.neovim = {
    extraPackages = with pkgs; [
      delta
      fd
      ripgrep
    ];
    plugins = with pkgs.vimPlugins; [
      fzf-lua
    ];
  };
  xdg.configFile."nvim/lua/plugins/ui/fzf-lua.lua".source =
    ../../src/lua/plugins/ui/fzf-lua.lua;
}
