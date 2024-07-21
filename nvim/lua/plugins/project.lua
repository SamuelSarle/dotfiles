return {
	"ahmedkhalf/project.nvim",
	event = "VeryLazy",
	main = "project_nvim",
	opts = {
		detection_methods = { "pattern", "lsp" },
		patterns = { ".git", "Makefile", "go.mod", "package.json" },
		exclude_dirs = { "node_modules/*", "~/go/pkg/*", "~/.cargo/*" },
		scope_chdir = "win",
	},
}
