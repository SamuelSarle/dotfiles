return {
	-- {
	-- 	"simrat39/rust-tools.nvim",
	-- 	ft = { "rust" },
	-- 	dependencies = "VonHeikemen/lsp-zero.nvim",
	-- 	config = function()
	-- 		local rt = require("rust-tools")
	-- 		rt.setup({
	-- 			server = {
	-- 				on_attach = function(_, bufnr)
	-- 					local opts = { buffer = bufnr }
	-- 					vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, opts)
	-- 					vim.keymap.set("n", "<leader>a", rt.code_action_group.code_action_group, opts)
	-- 				end,
	-- 			},
	-- 		})
	-- 	end,
	-- },
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
