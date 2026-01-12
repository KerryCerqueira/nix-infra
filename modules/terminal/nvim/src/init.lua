require("options").setup()
require("lazy-setup").setup()
require("keymaps").setup()
require("autocommands").setup()
local secrets_ok, secrets = pcall(require, "secrets")
if secrets_ok then secrets.setup() end
local extra_ok, extra_config = pcall(require, "extra-config")
if extra_ok then extra_config.setup() end
