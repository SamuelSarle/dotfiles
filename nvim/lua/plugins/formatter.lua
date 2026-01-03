return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				astro = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd", "prettier", stop_after_first = true },
				elixir = { "mix" },
				go = { "gofumpt", "golines" },
				html = { "prettierd", "prettier", stop_after_first = true },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				lua = { "stylua" },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
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
			format_on_save = function(bufnr)
				-- Disable with a global or buffer-local variable
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { timeout_ms = 500, lsp_format = "fallback" }
			end,
			default_format_opts = {
				lsp_format = "fallback",
			},
		},
	},
}
