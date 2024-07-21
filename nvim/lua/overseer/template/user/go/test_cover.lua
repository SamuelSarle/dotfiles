return {
	name = "Test Go module and open coverage report",
	builder = function()
		return {
			cmd = "go test -coverprofile=c.out ./... && go tool cover -html=c.out && unlink c.out",
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
