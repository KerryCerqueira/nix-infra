{...}: {
  flake.wrappers.neovim = {
    pkgs,
    config,
    ...
  }: {
    lazy = {
      plugins = {
        blink-cmp = {
          name = "blink.cmp";
          pkg = pkgs.vimPlugins.blink-cmp;
        };
        colorful-menu-nvim = {
          name = "colorful-menu.nvim";
          pkg = pkgs.vimPlugins.colorful-menu-nvim;
        };
        friendly-snippets = {
          name = "friendly-snippets";
          pkg = pkgs.vimPlugins.friendly-snippets;
        };
        luasnip = {
          name = "LuaSnip";
          pkg = pkgs.vimPlugins.luasnip;
        };
      };
      specs = [
        (config.lazy.configSrc + "/lua/lazyspecs/completion.lua")
      ];
    };
    settings.nvim_lua_env = lp: [lp.jsregexp];
  };
}
