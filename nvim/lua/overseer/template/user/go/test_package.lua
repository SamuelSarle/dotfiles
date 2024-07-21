return {
	name = "Test current Go package",
	builder = function()
		local dir = vim.fn.expand("%:p:h")
		return {
			cmd = { "go", "test", "-v", "." },
			cwd = dir,
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
