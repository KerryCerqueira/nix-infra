{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    rustaceanvim
    crates-nvim
  ];
  xdg.configFile = {
    "nvim/lua/plugins/lang/rust.lua".source =
      ../../src/lua/plugins/lang/rust.lua;
    "nvim/ftplugin/rust.lua".source =
      ../../src/ftplugin/rust.lua;
  };
}
