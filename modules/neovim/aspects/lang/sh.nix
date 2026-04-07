{...}: {
  flake.wrappers.neovim = {
    pkgs,
    lib,
    config,
    ...
  }: {
    options.aspects.lang.sh.enable =
      lib.mkEnableOption
      "shell script editing features";
    config = lib.mkIf config.aspects.lang.sh.enable {
      extraPackages = with pkgs; [
        bash-language-server
        fish-lsp
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
