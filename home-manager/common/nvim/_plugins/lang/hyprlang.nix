{pkgs, ...}: {
  programs.neovim = {
    extraPackages = with pkgs; [hyprls];
    plugins = [pkgs.vimPlugins.nvim-lspconfig];
  };
  xdg.configFile = {
    "nvim/lsp/hyprls.lua".source =
      ../../src/lsp/hyprls.lua;
  };
}
