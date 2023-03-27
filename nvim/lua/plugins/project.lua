return {
	"ahmedkhalf/project.nvim",
	event = "VeryLazy",
	main = "project_nvim",
	opts = {
		detection_methods = { "pattern", "lsp" },
		scope_chdir = "win",
	},
}
