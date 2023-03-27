return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	opts = {
		sections = { lualine_c = { "lsp_progress" } },
		options = {
			icons_enabled = false,
			section_separators = "",
			component_separators = "",
		},
	},
	dependencies = { "arkav/lualine-lsp-progress" },
}
