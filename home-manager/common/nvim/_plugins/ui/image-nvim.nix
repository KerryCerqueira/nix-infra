{pkgs, ...}: {
  programs.neovim = {
    plugins = [pkgs.vimPlugins.image-nvim];
    lazyNixCompat.idOverrides = {
      "image.nvim" = "3rd/image.nvim";
    };
  };
  xdg.configFile = {
    "nvim/lua/plugins/ui/image-nvim.lua".source =
      ../../src/lua/plugins/ui/image-nvim.lua;
  };
}
