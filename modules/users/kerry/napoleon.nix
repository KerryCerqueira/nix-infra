{self, ...}: {
  flake.nixosModules.napoleon = {config, ...}: {
    users.users.kerry = {
      isNormalUser = true;
      description = "Kerry Cerqueira";
      extraGroups = ["networkmanager" "wheel" "extra-store"];
      hashedPasswordFile = config.sops.secrets."hashedUserPasswords/kerry".path;
      uid = 1000;
    };
    home-manager.users.kerry = self.homeModules."kerry@napoleon";
  };
  flake.homeModules."kerry@napoleon" = {
    config,
    pkgs,
    ...
  }: {
    imports = [
      self.homeModules.kerry
    ];
    home.stateVersion = "25.11";
    programs.ssh.matchBlocks."*".identityFile = "~/.ssh/id_ed25519";
    sops = {
      defaultSopsFile = ./napoleon_secrets.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = "/home/kerry/.config/sops/age/keys.txt";
      secrets = {
        "syncthing/cert" = {
          path = "${config.home.homeDirectory}/.config/syncthing/cert.pem";
        };
        "syncthing/key" = {
          path = "${config.home.homeDirectory}/.config/syncthing/key.pem";
        };
        "apiKeys/tavily" = {};
        "apiKeys/huggingface" = {};
      };
    };
    xdg.configFile = {
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
}
