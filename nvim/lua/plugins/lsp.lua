return {
	"VonHeikemen/lsp-zero.nvim",
	event = "VeryLazy",
	dependencies = {
		-- LSP Support
		"neovim/nvim-lspconfig",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",

		"jose-elias-alvarez/null-ls.nvim",
	},
	config = function()
		local lsp = require("lsp-zero")
		lsp.preset("recommended")
		lsp.skip_server_setup({ "rust_analyzer" })
		lsp.ensure_installed({
			"tsserver",
			"eslint",
			-- "sumneko_lua",
			"gopls",
			"svelte",
			"tailwindcss",
			"rust_analyzer",
		})
		lsp.set_preferences({
			suggest_lsp_servers = false,
			sign_icons = {
				error = "E",
				warn = "W",
				hint = "H",
				info = "I",
			},
		})
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		lsp.on_attach(function(client, bufnr)
			local opts = { buffer = bufnr, remap = false }
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
			vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({
							bufnr = bufnr,
							filter = function(cl)
								return cl.name == "null-ls"
							end,
						})
					end,
				})
			end
		end)
		lsp.nvim_workspace()
		lsp.setup()
		vim.diagnostic.config({
			virtual_text = true,
		})

		local null_opts = lsp.build_options("null-ls", {})
		require("null-ls").setup({
			on_attach = null_opts.on_attach,
			sources = {
				require("null-ls").builtins.formatting.stylua,
				require("null-ls").builtins.diagnostics.golangci_lint,
				require("null-ls").builtins.formatting.gofumpt,
				require("null-ls").builtins.formatting.golines,
				require("null-ls").builtins.formatting.goimports_reviser,
				require("null-ls").builtins.formatting.rustfmt,
				require("null-ls").builtins.formatting.prettierd.with({ extra_filetypes = { "svelte" } }),
			},
		})
	end,
}
