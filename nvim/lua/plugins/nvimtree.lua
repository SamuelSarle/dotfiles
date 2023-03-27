return {
	"nvim-tree/nvim-tree.lua",
	tag = "nightly",
	opts = {
		sync_root_with_cwd = true,
		respect_buf_cwd = true,
		update_focused_file = {
			enable = true,
			update_root = true,
		},
	},
	keys = {
		{ "<leader>t", vim.cmd.NvimTreeToggle },
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
