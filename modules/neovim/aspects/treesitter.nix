{...}: {
  flake.wrappers.neovim = {
    pkgs,
    lib,
    config,
    ...
  }: {
    options.aspects.treesitter.enable =
      lib.mkEnableOption
      "Treesitter features";
    config = lib.mkIf config.aspects.treesitter.enable {
      lazy = {
        plugins = {
          nvim-treesitter = {
            name = "nvim-treesitter";
            pkg = pkgs.vimPlugins.nvim-treesitter;
          };
          nvim-treesitter-context = {
            name = "nvim-treesitter-context";
            pkg = pkgs.vimPlugins.nvim-treesitter-context;
          };
          nvim-treesitter-endwise = {
            name = "nvim-treesitter-endwise";
            pkg = pkgs.vimPlugins.nvim-treesitter-endwise;
          };
          nvim-treesitter-textobjects = {
            name = "nvim-treesitter-textobjects";
            pkg = pkgs.vimPlugins.nvim-treesitter-textobjects;
          };
          nvim-ufo = {
            name = "nvim-ufo";
            pkg = pkgs.vimPlugins.nvim-ufo;
          };
          promise-async = {
            name = "promise-async";
            pkg = pkgs.vimPlugins.promise-async;
          };
        };
        specs = [
          (config.lazy.configSrc + "/lua/lazyspecs/treesitter.lua")
        ];
      };
      treesitter = {
        enable = true;
        grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          html
          bash
          json
          markdown
          markdown_inline
          regex
          ssh_config
          toml
          tsv
          vim
          vimdoc
          xml
          yaml
        ];
      };
    };
  };
}
