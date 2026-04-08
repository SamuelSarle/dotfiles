vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	once = true,
	callback = function()
		vim.diagnostic.config({ severity_sort = true, virtual_text = true })
		vim.lsp.enable({
			"basedpyright",
			"bqnlsp",
			"clangd",
			"expert",
			"fish_lsp",
			"gopls",
			"lua_ls",
			-- "pyright",
			"ruff",
			"solargraph",
			"svelte",
			"tailwindcss",
			"taplo",
			"ts_ls",
			-- "ty",
			"zls",
		})
	end,
})
