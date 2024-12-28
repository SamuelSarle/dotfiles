return {
	{
		"zenbones-theme/zenbones.nvim",
		dependencies = "rktjmp/lush.nvim",
		config = function()
			local opts = {
				transparent_background = true,
				lightness = "bright",
				darkness = "stark",
				italic_comments = false,
			}

			vim.g.zenbones = opts
			vim.g.zenwritten = opts
		end,
	},
	{
		"f-person/auto-dark-mode.nvim",
		event = "UIEnter",
		opts = {},
	},
}
