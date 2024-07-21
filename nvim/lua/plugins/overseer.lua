return {
	"stevearc/overseer.nvim",
	opts = {
		templates = { "builtin", "user.go" },
	},
	keys = {
		{ "<leader>or", ":OverseerRun<CR>" },
		{ "<leader>ot", ":OverseerToggle<CR>" },
		{ "<leader>oa", ":OverseerQuickAction<CR>" },
	},
	cmd = { "OverseerRun", "OverseerToggle" },
}
