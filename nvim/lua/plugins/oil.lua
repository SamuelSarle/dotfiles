return {
	"stevearc/oil.nvim",
	opts = {},
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = { "Oil" },
	event = "VimEnter",
	keys = {
		{ "<leader>d", "<cmd>Oil<cr>" },
	},
}
