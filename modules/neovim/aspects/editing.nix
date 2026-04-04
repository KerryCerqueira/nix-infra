{...}: {
  flake.wrappers.neovim = {
    pkgs,
    config,
    ...
  }: {
    lazy = {
      plugins = {
        mini-bracketed = {
          name = "mini.bracketed";
          pkg = pkgs.vimPlugins.mini-bracketed;
        };
        mini-comment = {
          name = "mini.comment";
          pkg = pkgs.vimPlugins.mini-comment;
        };
        mini-splitjoin = {
          name = "mini.splitjoin";
          pkg = pkgs.vimPlugins.mini-splitjoin;
        };
        mini-surround = {
          name = "mini.surround";
          pkg = pkgs.vimPlugins.mini-surround;
        };
        mini-trailspace = {
          name = "mini.trailspace";
          pkg = pkgs.vimPlugins.mini-trailspace;
        };
        nvim-ts-context-commentstring = {
          name = "nvim-ts-context-commentstring";
          pkg = pkgs.vimPlugins.nvim-ts-context-commentstring;
        };
        nvim-various-textobjs = {
          name = "nvim-various-textobjs";
          pkg = pkgs.vimPlugins.nvim-various-textobjs;
        };
        substitute-nvim = {
          name = "substitute.nvim";
          pkg = pkgs.vimPlugins.substitute-nvim;
        };
      };
      specs = [
        (config.lazy.configSrc + "/lua/lazyspecs/editing.lua")
      ];
    };
  };
}
