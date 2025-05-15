return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "helix",
		filter = function(mapping)
			return mapping.desc and mapping.desc ~= ""
		end,
		expand = 2,
		spec = {
			{ "<leader>f", group = "Find" },
			{ "<leader>h", group = "Git" },
			{ "<leader>o", group = "Overseer" },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
