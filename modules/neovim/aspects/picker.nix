{...}: {
  flake.wrappers.neovim = {
    pkgs,
    config,
    ...
  }: {
    lazy = {
      plugins = {
        fzf-lua = {
          name = "fzf-lua";
          pkg = pkgs.vimPlugins.fzf-lua;
        };
        mini-icons = {
          name = "mini.icons";
          pkg = pkgs.vimPlugins.mini-icons;
        };
      };
      specs = [
        (config.lazy.configSrc + "/lua/lazyspecs/picker.lua")
      ];
    };
    extraPackages = with pkgs; [
      delta
      fd
      fzf
      ripgrep
    ];
  };
}
