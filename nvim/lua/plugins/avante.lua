return {
	"yetone/avante.nvim",
	version = "*",
	opts = {},
	build = "make",
	cmd = { "AvanteAsk" },
	keys = {
		{ "<leader>aa", "<cmd>AvanteAsk<cr>" },
	},
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
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
