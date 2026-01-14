{...}: {
  flake.homeModules."kerry@napoleon" = {
    config,
    pkgs,
    ...
  }: {
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
  };
}
