return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	config = function()
		require("copilot").setup({
			suggestion = {
				auto_trigger = true,
			},
		})
	end,
}
