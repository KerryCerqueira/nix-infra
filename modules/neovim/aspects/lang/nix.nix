{...}: {
  flake.wrappers.neovim = {
    pkgs,
    lib,
    config,
    ...
  }: {
    options.aspects.lang.nix.enable =
      lib.mkEnableOption
      "nix code editing features";
    config = lib.mkIf config.aspects.lang.nix.enable {
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
  };
}
