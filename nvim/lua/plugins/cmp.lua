return {
	{
		"saghen/blink.cmp",
		version = "1.*",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },
		opts = {
			snippets = { preset = "luasnip" },
			keymap = { preset = "default" },
			completion = { documentation = { auto_show = true } },
			sources = { default = { "lsp", "path", "snippets", "buffer" } },
			signature = { enabled = true },
		},
		opts_extend = { "sources.default" },
	},
}
