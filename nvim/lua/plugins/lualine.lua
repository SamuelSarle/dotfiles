return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	opts = function()
		local statusline = require("arrow.statusline")
		local function arrow_status()
			return statusline.text_for_statusline_with_icons()
		end
		return {
			sections = {
				lualine_a = { "mode" },
				lualine_c = {
					"lsp_progress",
					"%=",
					arrow_status,
					"filename",
				},
			},
			options = {
				icons_enabled = true,
				section_separators = "",
				component_separators = "",
			},
		}
	end,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"arkav/lualine-lsp-progress",
	},
}
