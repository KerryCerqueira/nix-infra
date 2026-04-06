{self, ...}: {
  flake.nixosModules.claudius = {
    users.users.kerry = {
      isNormalUser = true;
      description = "Kerry Cerqueira";
      extraGroups = ["networkmanager" "wheel"];
    };
    home-manager.users.kerry = self.homeModules."kerry@claudius";
  };
  flake.homeModules."kerry@claudius" = {
    config,
    pkgs,
    lib,
    ...
  }: {
    imports = with self.homeModules; [
      kerry
      claude-desktop
    ];
    sops = {
      defaultSopsFile = ./claudius_secrets.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = "${config.home.homeDirectory}/.config/sops/age/kerry_claudius.age";
      secrets = {
        "apiKeys/github/claude-code" = {};
        "apiKeys/tavily" = {};
        "apiKeys/huggingface" = {};
        "apiKeys/openai" = {};
        "ssh/identity/private" = {
          path = "${config.home.homeDirectory}/.ssh/id_ed25519";
        };
        "ssh/identity/public" = {
          path = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
        };
        "syncthing/cert" = {
          path = "${config.home.homeDirectory}/.config/syncthing/cert.pem";
        };
        "syncthing/key" = {
          path = "${config.home.homeDirectory}/.config/syncthing/key.pem";
        };
      };
      templates."claude_desktop_config.json" = {
        content = builtins.toJSON {
          mcpServers = config.programs.claude-desktop.mcpServers;
        };
        path = "${config.xdg.configHome}/Claude/claude_desktop_config.json";
      };
    };
    home.stateVersion = "24.11";
    programs = {
      claude-desktop.mcpServers = {
        github = {
          command = lib.getExe pkgs.github-mcp-server;
          args = ["stdio"];
          env = {
            GITHUB_PERSONAL_ACCESS_TOKEN = config.sops.placeholder."apiKeys/github/claude-code";
          };
        };
      };
      ssh.matchBlocks."*".identityFile = "~/.ssh/id_ed25519";
    };
    xdg = {
      configFile."nvim/lua/secrets/init.lua".text =
        # lua
        ''
          return {
          	setup = function()
          		require("secrets.tavily").setup()
          	end
          }
        '';
      configFile."nvim/lua/secrets/tavily.lua".text = let
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
}
