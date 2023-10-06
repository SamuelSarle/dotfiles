return {
	{
		"ramojus/mellifluous.nvim",
		opts = { color_set = "mountain" },
		dependencies = { "rktjmp/lush.nvim" },
	},
	{ "mcchrish/zenbones.nvim", dependencies = { "rktjmp/lush.nvim" } },
	{
		"projekt0n/github-nvim-theme",
		tag = "v0.0.7",
		main = "github-theme",
		config = {
			transparent = true,
		},
	},
}
