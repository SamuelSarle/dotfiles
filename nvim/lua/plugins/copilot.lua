return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	keys = {
		{ "<leader>c", ":Copilot! attach<CR>" },
	},
	opts = {
		suggestion = {
			auto_trigger = true,
		},
		filetypes = {
			javascript = true,
			typescript = true,
			lua = true,
			go = true,
			["*"] = false,
		},
	},
}
