return {
	{
		"folke/flash.nvim",
		opts = {
			label = {
				uppercase = false,
				exclude = "jJ",
			},
			jump = {
				autojump = true,
			},
		},
		keys = {
			"f",
			"F",
			"t",
			"T",
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
		},
	},
	{
		"otavioschwanck/arrow.nvim",
		keys = { ";", "m" },
		opts = {
			show_icons = true,
			leader_key = ";",
			buffer_leader_key = "m",
			save_path = function()
				return vim.fn.stdpath("cache") .. "/arrow"
			end,
		},
	},
}
