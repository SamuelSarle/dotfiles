return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "LspInfo", "LspLog", "LspRestart", "LspStart", "LspStop" },
		config = function()
			vim.diagnostic.config({ severity_sort = true, virtual_text = true })

			vim.lsp.enable({
				"bqnlsp",
				"clangd",
				"elixirls",
				"fish_lsp",
				"gopls",
				"lua_ls",
				"pyright",
				"ruff",
				"solargraph",
				"svelte",
				"tailwind",
				"taplo",
				"ts_ls",
				"zls",
			})
		end,
	},
	{
		"chrisgrieser/nvim-lsp-endhints",
		event = { "LspAttach" },
		opts = {},
	},
}
