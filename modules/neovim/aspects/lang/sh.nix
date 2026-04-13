{...}: {
  flake.wrappers.neovim = {
    pkgs,
    lib,
    config,
    ...
  }: {
    config = lib.mkIf config.aspects.lang.sh.enable {
      extraPackages = with pkgs; [
        shellcheck
      ];
      lazy = {
        plugins = {
          conform-nvim = {
            name = "conform.nvim";
            pkg = pkgs.vimPlugins.conform-nvim;
          };
        };
        specs = [
          (config.lazy.configSrc + "/lua/lazyspecs/lang/sh.lua")
        ];
      };
      lspConfig = {
        bashls.pkg = pkgs.bash-language-server;
        fish_lsp.pkg = pkgs.fish-lsp;
      };
      treesitter = {
        enable = true;
        grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
          fish
          zsh
        ];
      };
    };
  };
}
