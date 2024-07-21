return {
	name = "Test Go module",
	builder = function()
		return {
			cmd = { "go", "test", "-v", "./..." },
			components = {
				{ "on_output_quickfix", set_diagnostics = true },
				"on_result_diagnostics",
				"default",
			},
		}
	end,
	condition = {
		filetypes = { "go", "gomod" },
	},
}
