{...}: {
  flake.wrappers.neovim = {
    pkgs,
    config,
    ...
  }: {
    extraPackages = with pkgs; [
      alejandra
      nil
    ];
    lazy = {
      specs = [
        (config.lazy.configSrc + "/lua/lazyspecs/lang/nix.lua")
      ];
    };
    treesitter = {
      enable = true;
      grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        nix
      ];
    };
  };
}
