return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				elixir = { "mix" },
				go = { "goimports-reviser", "gofumpt", "golines" },
				rust = { "rustfmt", lsp_format = "fallback" },
				html = { "prettierd", "prettier", stop_after_first = true },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				svelte = { "prettierd", "prettier", stop_after_first = true },
				astro = { "prettierd", "prettier", stop_after_first = true },
				yaml = { "yamlfmt" },
				tex = { "tex-fmt" },
			},
			format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
			default_format_opts = {
				lsp_format = "fallback",
			},
		},
	},
}
