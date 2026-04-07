{...}: {
  flake.wrappers.neovim = {
    pkgs,
    lib,
    config,
    ...
  }: {
    options.aspects.git.enable =
      lib.mkEnableOption
      "Git integration features";
    config = lib.mkIf config.aspects.git.enable {
      lazy.plugins = {
        neogit = {
          name = "neogit";
          pkg = pkgs.vimPlugins.neogit;
        };
        blink-cmp-git = {
          name = "blink-cmp-git";
          pkg = pkgs.vimPlugins.blink-cmp-git;
        };
        gitsigns-nvim = {
          name = "gitsigns.nvim";
          pkg = pkgs.vimPlugins.gitsigns-nvim;
        };
        plenary-nvim = {
          name = "plenary.nvim";
          pkg = pkgs.vimPlugins.plenary-nvim;
        };
        diffview-nvim = {
          name = "diffview.nvim";
          pkg = pkgs.vimPlugins.diffview-nvim;
        };
        fzf-lua = {
          name = "fzf-lua";
          pkg = pkgs.vimPlugins.fzf-lua;
        };
      };
      lazy.specs = [
        (config.lazy.configSrc + "/lua/lazyspecs/git.lua")
      ];
      extraPackages = with pkgs; [
        git
        curl
      ];
      treesitter = {
        enable = true;
        grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          diff
          git_config
          git_rebase
          gitattributes
          gitcommit
          gitignore
        ];
      };
    };
  };
}
