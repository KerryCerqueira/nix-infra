{config, ...}: {
  home.stateVersion = "24.11";
  programs.ssh.matchBlocks."*".identityFile = "~/.ssh/id_ed25519";
  sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/kerry_sigmund.age";
    secrets = {
      "syncthing/cert" = {
        path = "${config.home.homeDirectory}/.config/syncthing/cert.pem";
      };
      "syncthing/key" = {
        path = "${config.home.homeDirectory}/.config/syncthing/key.pem";
      };
      "apiKeys/tavily" = {};
      "ssh/identity/public" = {
        path = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
      };
      "ssh/identity/private" = {
        path = "${config.home.homeDirectory}/.ssh/id_ed25519";
      };
    };
  };
  xdg.configFile."nvim/lua/secrets/init.lua".text =
    # lua
    ''
      return {
        setup = function()
          require("secrets.tavily").setup()
        end
      }
      '';
      xdg.configFile."nvim/lua/secrets/tavily.lua".text = let
      tavilyKeyPath = config.sops.secrets."apiKeys/tavily".path;
      in
      # lua
      ''
      return {
        setup = function()
          local keyfile = "${tavilyKeyPath}"
          local ok, key = pcall(function()
            return vim.fn.readfile(keyfile)[1]
          end)
          if ok and key and #key > 0 then
            vim.env.TAVILY_API_KEY = key
          else
            vim.notify("Tavily API key unavailable.", vim.log.levels.WARN)
          end
        end,
      }
      '';
}
