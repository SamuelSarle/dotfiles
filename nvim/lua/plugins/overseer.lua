return {
	{
		"stevearc/overseer.nvim",
		opts = {
			templates = { "builtin", "user.go" },
		},
		keys = {
			{ "<leader>or", ":OverseerRun<CR>", desc = "Overseer run" },
			{ "<leader>ot", ":OverseerToggle<CR>", desc = "Overseer toggle" },
			{ "<leader>oa", ":OverseerQuickAction<CR>", desc = "Overseer quick action" },
		},
		cmd = { "OverseerRun", "OverseerToggle" },
	},
}
