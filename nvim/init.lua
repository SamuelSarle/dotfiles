if vim.loader then
	vim.loader.enable()
end

vim.g.mapleader = " "

require("config.options")
require("config.lazy")
require("config.colorscheme")
require("config.autocmds")
require("config.commands")
require("config.keymaps")
