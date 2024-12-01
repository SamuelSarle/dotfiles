return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		---@module "conform"
		---@type conform.setupOpts
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
			},
			format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
			default_format_opts = {
				lsp_format = "fallback",
			},
		},
	},
	-- {
	-- 	"mhartington/formatter.nvim",
	-- 	event = "BufReadPost",
	-- 	config = function()
	-- 		local augroup = vim.api.nvim_create_augroup("FormatAutogroup", {})
	-- 		vim.api.nvim_create_autocmd("BufWritePost", {
	-- 			group = augroup,
	-- 			command = [[FormatWrite]],
	-- 		})
	-- 		require("formatter").setup({
	-- 			logging = true,
	-- 			log_level = vim.log.levels.WARN,
	-- 			filetype = {
	-- 				lua = {
	-- 					require("formatter.filetypes.lua").stylua,
	-- 				},
	-- 				go = {
	-- 					require("formatter.filetypes.go").goimports,
	-- 					{ exe = "goimports-reviser" },
	-- 					-- combine golines and gofumpt
	-- 					-- require("formatter.filetypes.go").golines,
	-- 					-- require("formatter.filetypes.go").gofumpt,
	-- 					{
	-- 						exe = "golines",
	-- 						args = { "--base-formatter", "gofumpt" },
	-- 						stdin = true,
	-- 					},
	-- 				},
	-- 				rust = {
	-- 					require("formatter.filetypes.rust").rustfmt,
	-- 				},
	-- 				javascript = {
	-- 					require("formatter.filetypes.javascript").prettierd,
	-- 				},
	-- 				typescript = {
	-- 					require("formatter.filetypes.typescript").prettierd,
	-- 				},
	-- 				typescriptreact = {
	-- 					require("formatter.filetypes.typescript").prettierd,
	-- 				},
	-- 				svelte = {
	-- 					require("formatter.filetypes.svelte").prettierd,
	-- 				},
	-- 				astro = {
	-- 					require("formatter.filetypes.javascript").prettierd,
	-- 				},
	-- 				html = {
	-- 					require("formatter.filetypes.html").prettier,
	-- 				},
	-- 				yaml = {
	-- 					require("formatter.filetypes.yaml").yamlfmt,
	-- 				},
	-- 				elixir = {
	-- 					require("formatter.filetypes.elixir").mixformat,
	-- 				},
	-- 				markdown = {
	-- 					require("formatter.filetypes.markdown").prettier,
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },
}
