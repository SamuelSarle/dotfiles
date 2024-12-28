return {
	{
		"mrcjkb/rustaceanvim",
		version = "^5",
		ft = { "rust" },
		config = function()
			vim.g.rustaceanvim = {
				tools = {
					float_win_config = {
						border = "rounded",
					},
				},
				server = {
					on_attach = function(client, bufnr)
						vim.lsp.inlay_hint.enable(true)
					end,
				},
			}
		end,
	},
}
