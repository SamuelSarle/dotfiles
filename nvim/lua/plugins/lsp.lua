local function setupBQN()
	local configs = require("lspconfig.configs")
	local util = require("lspconfig.util")
	if not configs.bqnlsp then
		configs.bqnlsp = {
			default_config = {
				cmd = { "bqnlsp" },
				cmd_env = {},
				filetypes = { "bqn" },
				root_dir = util.find_git_ancestor,
				single_file_support = false,
			},
			docs = {
				description = [[
      BQN Language Server
  ]],
				default_config = {
					root_dir = [[util.find_git_ancestor]],
				},
			},
		}
	end
	require("lspconfig").bqnlsp.setup({})
end

return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v4.x",
		config = false,
	},
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "williamboman/mason.nvim", cmd = { "Mason" }, opts = { ui = { border = "rounded" } } },
			{ "williamboman/mason-lspconfig.nvim" },
		},
		config = function()
			-- local lsp_zero = require("lsp-zero")
			-- lsp_zero.extend_lspconfig()
			-- lsp_zero.set_sign_icons({
			-- 	error = "✘",
			-- 	warn = "▲",
			-- 	hint = "⚑",
			-- 	info = "»",
			-- })
			local lspconfig_defaults = require("lspconfig").util.default_config
			lspconfig_defaults.capabilities = vim.tbl_deep_extend(
				"force",
				lspconfig_defaults.capabilities,
				require("cmp_nvim_lsp").default_capabilities()
			)
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				width = 40,
				border = "single",
			})
			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = "single",
			})
			vim.diagnostic.config({
				virtual_text = true,
				float = { border = "rounded" },
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf, remap = false }

					-- see :help lsp-zero-keybindings
					-- to learn the available actions
					-- local opts = { buffer = bufnr, remap = false }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<leader>ps", "<cmd>Telescope lsp_document_symbols<CR>", opts)
					vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
					vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
				end,
			})

			-- setupBQN()

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"ts_ls",
					"eslint",
					"gopls",
					"svelte",
					"tailwindcss",
					"rust_analyzer",
					"elixirls",
					"lua_ls",
				},
				automatic_installation = { exclude = { "rust_analyzer" } },
				handlers = {
					-- this first function is the "default handler"
					-- it applies to every language server without a "custom handler"
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,

					rust_analyzer = function() end,
				},
			})
		end,
	},
}
