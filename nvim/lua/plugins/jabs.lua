return {
	"matbme/JABS.nvim",
	opts = {
		position = { "center", "center" },
		width = 80, -- default 50
		height = 20, -- default 10
	},
	keys = {
		{ "<leader>b", vim.cmd.JABSOpen },
	},
}
