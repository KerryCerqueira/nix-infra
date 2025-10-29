{ config, ... }:
{
	home = {
		stateVersion = "24.11";
		file.".ssh/config".text = /*sshconfig*/ ''
		Host *
			IdentityFile ~/.ssh/id_ed25519
			IdentitiesOnly yes
			ServerAliveInterval 15
			ServerAliveCountMax 3
			AddKeysToAgent yes

		Include ~/.ssh/config.d/*.conf
		'';
	};
	sops = {
		defaultSopsFile = ./secrets.yaml;
		defaultSopsFormat = "yaml";
		age.keyFile = "/home/kerry/.config/sops/age/kerry_claudius.age";
		secrets = {
			"syncthing/cert" = {
				path = "/home/kerry/.config/syncthing/cert.pem";
			};
			"syncthing/key" = {
				path = "/home/kerry/.config/syncthing/key.pem";
			};
			"apiKeys/tavily" = {};
			"apiKeys/huggingface" = {};
			"apiKeys/openai" = {};
			"ssh/identity/private" = {
				path = "/home/kerry/.ssh/id_ed25519";
			};
			"ssh/identity/public" = {
				path = "/home/kerry/.ssh/id_ed25519.pub";
			};
		};
	};
	xdg.configFile."nvim/lua/secrets/tavily.lua".text = let
		tavilyKeyPath = config.sops.secrets."apiKeys/tavily".path;
	in # lua
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
				end,
			end,
		}
		'';
	services = {
		syncthing = {
			enable = true;
			tray.enable = true;
			tray.command = "syncthingtray --wait";
		};
	};
}
