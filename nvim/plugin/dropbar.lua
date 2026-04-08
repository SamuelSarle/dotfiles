vim.pack.add({ "https://github.com/Bekaboo/dropbar.nvim" })

vim.api.nvim_create_autocmd("BufReadPost", {
	once = true,
	callback = function()
		require("dropbar").setup()
	end,
})
