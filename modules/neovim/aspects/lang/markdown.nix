{...}: {
  flake.wrappers.neovim = {
    pkgs,
    lib,
    config,
    ...
  }: {
    options.aspects.lang.markdown.enable =
      lib.mkEnableOption
      "markdown editing features";
    config = lib.mkIf config.aspects.lang.markdown.enable {
      extraPackages = with pkgs; [
        markdownlint-cli2
        marksman
        python312Packages.pylatexenc
        prettier
      ];
      lazy = {
        plugins = {
          conform-nvim = {
            name = "conform.nvim";
            pkg = pkgs.vimPlugins.conform-nvim;
          };
          render-markdown-nvim = {
            name = "render-markdown.nvim";
            pkg = pkgs.vimPlugins.render-markdown-nvim;
          };
          snacks-nvim = {
            name = "snacks.nvim";
            pkg = pkgs.vimPlugins.snacks-nvim;
          };
          nvim-lint = {
            name = "nvim-lint";
            pkg = pkgs.vimPlugins.nvim-lint;
          };
        };
        specs = [
          (config.lazy.configSrc + "/lua/lazyspecs/lang/markdown.lua")
        ];
      };
      treesitter = {
        enable = true;
        grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          markdown
          markdown_inline
          html
          latex
          yaml
        ];
      };
    };
  };
}
