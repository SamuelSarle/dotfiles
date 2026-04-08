vim.pack.add({ "https://github.com/monaqa/dial.nvim" })

vim.keymap.set("n", "<C-a>", function()
	return require("dial.map").inc_normal()
end, { expr = true })

vim.keymap.set("n", "<C-x>", function()
	return require("dial.map").dec_normal()
end, { expr = true })

vim.keymap.set("v", "<C-a>", function()
	return require("dial.map").inc_visual()
end, { expr = true })

vim.keymap.set("v", "<C-x>", function()
	return require("dial.map").dec_visual()
end, { expr = true })

vim.keymap.set("v", "g<C-a>", function()
	return require("dial.map").inc_gvisual()
end, { expr = true })

vim.keymap.set("v", "g<C-x>", function()
	return require("dial.map").dec_gvisual()
end, { expr = true })
