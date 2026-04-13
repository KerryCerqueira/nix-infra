{...}: {
  flake.wrappers.neovim = {
    pkgs,
    lib,
    config,
    ...
  }: {
    config = lib.mkIf config.aspects.lang.nix.enable {
      extraPackages = with pkgs; [alejandra];
      lazy = {
        specs = [
          (config.lazy.configSrc + "/lua/lazyspecs/lang/nix.lua")
        ];
      };
      lspConfig.nil_ls.pkg = pkgs.nil;
      treesitter = {
        enable = true;
        grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          nix
        ];
      };
    };
  };
}
