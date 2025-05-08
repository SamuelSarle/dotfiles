return {
	"yetone/avante.nvim",
	opts = {},
	build = "make",
	cmd = { "AvanteAsk" },
	keys = {
		{ "<leader>aa", "<cmd>AvanteAsk<cr>", desc = "Avante ask", mode = { "n", "x" } },
	},
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
				code = {
					border = "none",
				},
			},
			ft = { "markdown", "Avante" },
		},
	},
}
