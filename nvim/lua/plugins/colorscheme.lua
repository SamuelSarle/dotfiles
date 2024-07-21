return {
	{
		"projekt0n/github-nvim-theme",
		tag = "v1.0.2",
		main = "github-theme",
		opts = {
			options = {
				transparent = true,
			},
		},
	},
	{
		"f-person/auto-dark-mode.nvim",
		event = "VimEnter",
		opts = {
			update_interval = 1500,
			set_dark_mode = function()
				vim.api.nvim_set_option_value("background", "dark", {})
				vim.cmd("colorscheme github_dark_high_contrast")
			end,
			set_light_mode = function()
				vim.api.nvim_set_option_value("background", "light", {})
				vim.cmd("colorscheme github_light_high_contrast")
			end,
		},
	},
}
