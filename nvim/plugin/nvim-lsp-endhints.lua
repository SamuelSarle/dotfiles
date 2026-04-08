vim.pack.add({ "https://github.com/chrisgrieser/nvim-lsp-endhints" })

vim.api.nvim_create_autocmd("LspAttach", {
	once = true,
	callback = function()
		require("lsp-endhints").setup()
	end,
})
