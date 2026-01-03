return {
	{
		"mrcjkb/rustaceanvim",
		version = "^6",
		ft = { "rust", "toml" },
		config = function()
			vim.g.rustaceanvim = {
				server = {
					on_attach = function(_client, bufnr)
						vim.keymap.set("n", "gra", function()
							vim.cmd.RustLsp("codeAction")
						end, { silent = true, buffer = bufnr, desc = "Rust code actions" })

						vim.keymap.set("n", "K", function()
							vim.cmd.RustLsp({ "hover", "actions" })
						end, { silent = true, buffer = bufnr, desc = "Rust hover actions" })

						vim.keymap.set("n", "gk", function()
							vim.cmd.RustLsp({ "renderDiagnostic", "current" })
						end, { silent = true, buffer = bufnr, desc = "Render rust lsp diagnostic" })
					end,
				},
			}
		end,
	},
}
