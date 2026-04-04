{...}: {
  flake.wrappers.neovim = {
    pkgs,
    config,
    ...
  }: {
    lazy = {
      plugins = {
        rustaceanvim = {
          name = "rustaceanvim";
          pkg = pkgs.vimPlugins.rustaceanvim;
        };
        crates-nvim = {
          name = "crates.nvim";
          pkg = pkgs.vimPlugins.crates-nvim;
        };
      };
      specs = [
        (config.lazy.configSrc + "/lua/lazyspecs/lang/rust.lua")
      ];
    };
    treesitter = {
      enable = true;
      grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        rust
      ];
    };
  };
}
