return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		opts = {
			formatters_by_ft = {
				astro = { "prettierd", "prettier", stop_after_first = true },
				elixir = { "mix" },
				go = { "goimports-reviser", "gofumpt", "golines" },
				html = { "prettierd", "prettier", stop_after_first = true },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				lua = { "stylua" },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				python = { "ruff" },
				rust = { "rustfmt", lsp_format = "fallback" },
				svelte = { "prettierd", "prettier", stop_after_first = true },
				tex = { "tex-fmt" },
				toml = { "taplo" },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				yaml = { "yamlfmt" },
			},
			formatters = {
				yamlfmt = {
					append_args = { "-formatter", "include_document_start=true,retain_line_breaks=true" },
				},
			},
			format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
			default_format_opts = {
				lsp_format = "fallback",
			},
		},
	},
}
