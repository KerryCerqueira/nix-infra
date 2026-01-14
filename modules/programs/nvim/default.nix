{self, ...}: {
  flake.nixosModules.nvim = {
    programs.neovim = {
      enable = true;
    };
  };
  flake.homeModules.nvim = {pkgs, ...}: {
    imports = [
      ./_plugins
      self.homeModules.lazyNixCompat
    ];
    home.packages = with pkgs; [
      wl-clipboard
    ];
    programs.neovim = {
      enable = true;
      withRuby = true;
      withNodeJs = true;
      withPython3 = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      defaultEditor = true;
      plugins = with pkgs.vimPlugins; [
        lazy-nvim
      ];
      extraLuaConfig = builtins.readFile ./src/init.lua;
      lazyNixCompat.enable = true;
    };
    xdg.configFile = {
      "nvim/lua/options.lua".source = ./src/lua/options.lua;
      "nvim/lua/autocommands.lua".source = ./src/lua/autocommands.lua;
      "nvim/lua/keymaps.lua".source = ./src/lua/keymaps.lua;
      "nvim/lua/lazy-setup.lua".text =
        #lua
        ''
          return {
          	setup = function()
          		require("lazy").setup({
          			spec = {
          				{ import = "plugins.ai" },
          				{ import = "plugins.ui" },
          				{ import = "plugins.coding" },
          				{ import = "plugins.editing" },
          				{ import = "plugins.git" },
          				{ import = "plugins.lang" },
          				{ import = "plugins.nixcompat" },
          				{ import = "plugins.extra" },
          			},
          			performance = {
          				reset_packpath = false,
          				rtp = { reset = false, },
          			},
          			install = { missing = false, },
          		})
          	end,
          }
        '';
    };
  };
}
