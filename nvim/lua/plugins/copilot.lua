return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	-- event = "InsertEnter",
	keys = {
		{ "<leader>c", "<cmd>Copilot! attach<cr>" },
	},
	opts = {
		suggestion = {
			auto_trigger = false,
		},
		filetypes = {
			["*"] = false,
		},
	},
}
