vim.pack.add({
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/stevearc/oil.nvim",
})

require("oil").setup({
	keymaps = { ["q"] = "actions.close" },
})

vim.keymap.set("n", "<leader>d", function()
	require("oil").open()
end, { desc = "Open oil" })
