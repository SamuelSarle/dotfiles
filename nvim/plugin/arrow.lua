vim.pack.add({
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/otavioschwanck/arrow.nvim",
})

require("arrow").setup({
	opts = {
		leader_key = ";",
		buffer_leader_key = "m",
		show_icons = true,
		-- global_bookmarks = true,
		separate_save_and_remove = true,
	},
})
