{self, ...}: {
  flake = {
    nixosModules.sebastiao = {config, ...}: {
      imports = [self.nixosModules.kerry];
      users.users.kerry = {
        hashedPasswordFile = config.sops.secrets."hashedUserPasswords/kerry".path;
      };
      home-manager.users.kerry = self.homeModules."kerry@sebastiao";
    };
    homeModules."kerry@sebastiao" = {config, ...}: {
      imports = with self.homeModules; [
        kerry
        easyeffects
      ];
      sops = {
        defaultSopsFile = ./sebastiao_secrets.yaml;
        defaultSopsFormat = "yaml";
        age.keyFile = "${config.xdg.configHome}/sops/age/kerry_sebastiao.age";
        secrets = {
          "apiKeys/github" = {};
          "apiKeys/tavily" = {};
          "apiKeys/huggingface" = {};
          "ssh/identity/private" = {
            path = "${config.home.homeDirectory}/.ssh/id_ed25519";
          };
          "ssh/identity/public" = {
            path = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
          };
        };
      };
      home.stateVersion = "25.11";
      programs = {
        claude-desktop.mcpServers.github.env = {
          GITHUB_PERSONAL_ACCESS_TOKEN = config.sops.placeholder."apiKeys/github";
        };
        mcp.servers.github.env = let
          secretPath = config.sops.secrets."apiKeys/github".path;
        in {
          GITHUB_PERSONAL_ACCESS_TOKEN = "{file:${secretPath}}";
        };
        ssh.settings."*".identityFile = "~/.ssh/id_ed25519";
      };
      xdg = {
        configFile = {
          "nvim/lua/secrets/init.lua".text =
            # lua
            ''
              return {
              	setup = function()
              		require("secrets.tavily").setup()
              	end
              }
            '';
          "nvim/lua/secrets/tavily.lua".text = let
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
        };
      };
    };
  };
}
