return {
	"nvim-lualine/lualine.nvim",
	event = "UIEnter",
	opts = {
		options = {
			icons_enabled = true,
			section_separators = "",
			component_separators = "",
		},
	},
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
}
