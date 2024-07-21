return {
	{
		"stevearc/dressing.nvim",
		event = { "VeryLazy" },
		opts = {
			input = {
				min_width = { 50, 0.2 },
			},
		},
	},
	{
		"rcarriga/nvim-notify",
		event = { "VeryLazy" },
		opts = function()
			vim.notify = require("notify")
			return {
				max_width = 50,
				stages = "static",
				render = "wrapped-compact",
			}
		end,
	},
}
