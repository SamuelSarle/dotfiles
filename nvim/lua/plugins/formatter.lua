return {
	{
		"mhartington/formatter.nvim",
		event = "BufReadPost",
		config = function()
			local augroup = vim.api.nvim_create_augroup("FormatAutogroup", {})
			vim.api.nvim_create_autocmd("BufWritePost", {
				group = augroup,
				command = [[FormatWrite]],
			})
			require("formatter").setup({
				logging = true,
				log_level = vim.log.levels.WARN,
				filetype = {
					lua = {
						require("formatter.filetypes.lua").stylua,
					},
					go = {
						require("formatter.filetypes.go").goimports,
						{ exe = "goimports-reviser" },
						-- combine golines and gofumpt
						-- require("formatter.filetypes.go").golines,
						-- require("formatter.filetypes.go").gofumpt,
						{
							exe = "golines",
							args = { "--base-formatter", "gofumpt" },
							stdin = true,
						},
					},
					rust = {
						require("formatter.filetypes.rust").rustfmt,
					},
					javascript = {
						require("formatter.filetypes.javascript").prettierd,
					},
					typescript = {
						require("formatter.filetypes.typescript").prettierd,
					},
					typescriptreact = {
						require("formatter.filetypes.typescript").prettierd,
					},
					svelte = {
						require("formatter.filetypes.svelte").prettierd,
					},
					astro = {
						require("formatter.filetypes.javascript").prettierd,
					},
					html = {
						require("formatter.filetypes.html").prettier,
					},
					yaml = {
						require("formatter.filetypes.yaml").yamlfmt,
					},
					elixir = {
						require("formatter.filetypes.elixir").mixformat,
					},
					markdown = {
						require("formatter.filetypes.markdown").prettier,
					},
				},
			})
		end,
	},
}
