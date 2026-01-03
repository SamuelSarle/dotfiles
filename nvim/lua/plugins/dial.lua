return {
	"monaqa/dial.nvim",
	keys = {
		{
			"<C-a>",
			function()
				return require("dial.map").inc_normal()
			end,
			expr = true,
		},
		{
			"<C-x>",
			function()
				return require("dial.map").dec_normal()
			end,
			expr = true,
		},
		{
			"<C-a>",
			function()
				return require("dial.map").inc_visual()
			end,
			expr = true,
			mode = "v",
		},
		{
			"<C-x>",
			function()
				return require("dial.map").dec_visual()
			end,
			expr = true,
			mode = "v",
		},
		{
			"g<C-a>",
			function()
				return require("dial.map").inc_gvisual()
			end,
			expr = true,
			mode = "v",
		},
		{
			"g<C-x>",
			function()
				return require("dial.map").dec_gvisual()
			end,
			expr = true,
			mode = "v",
		},
	},
}
