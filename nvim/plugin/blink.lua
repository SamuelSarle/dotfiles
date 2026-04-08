vim.pack.add({
	{ src = "https://github.com/L3MON4D3/LuaSnip", version = vim.version.range("v2.*") },
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
})

vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
	once = true,
	callback = function()
		require("blink.cmp").setup({
			snippets = { preset = "luasnip" },
			keymap = { preset = "default" },
			completion = { documentation = { auto_show = true } },
			sources = { default = { "lsp", "path", "snippets", "buffer" } },
			signature = { enabled = true },
		})
	end,
})
