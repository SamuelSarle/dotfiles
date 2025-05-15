-- local function setupBQN()
-- 	local configs = require("lspconfig.configs")
-- 	local util = require("lspconfig.util")
-- 	if not configs.bqnlsp then
-- 		configs.bqnlsp = {
-- 			default_config = {
-- 				cmd = { "bqnlsp" },
-- 				cmd_env = {},
-- 				filetypes = { "bqn" },
-- 				root_dir = util.find_git_ancestor,
-- 				single_file_support = false,
-- 			},
-- 			docs = {
-- 				description = [[
--       BQN Language Server
--   ]],
-- 				default_config = {
-- 					root_dir = [[util.find_git_ancestor]],
-- 				},
-- 			},
-- 		}
-- 	end
-- 	require("lspconfig").bqnlsp.setup({})
-- end

return {
	{
		"mason-org/mason-lspconfig.nvim",
		event = { "BufEnter" },
		opts = {
			ensure_installed = {
				"elixirls",
				"eslint",
				"gopls",
				"lua_ls",
				"nil_ls",
				"pyright",
				"ruff",
				"solargraph",
				"svelte",
				"tailwindcss",
				"ts_ls",
			},
		},
		dependencies = {
			{ "mason-org/mason.nvim", cmd = { "Mason" }, opts = {} },
			{
				"neovim/nvim-lspconfig",
				cmd = { "LspInfo", "LspInstall", "LspStart" },
				config = function()
					vim.diagnostic.config({
						virtual_text = { virt_text_pos = "eol_right_align" },
						severity_sort = true,
						virtual_lines = { current_line = true },
					})

					vim.api.nvim_create_autocmd("LspAttach", {
						desc = "LSP actions",
						callback = function(event)
							local function map(mode, l, r, opts)
								opts = opts or {}
								opts.buffer = event.buf
								opts.remap = false
								vim.keymap.set(mode, l, r, opts)
							end

							map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
							map("n", "gD", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
							map(
								"n",
								"<leader>ws",
								vim.lsp.buf.workspace_symbol,
								{ desc = "Search for workspace symbol" }
							)
							map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open diagnostic" })
						end,
					})

					vim.api.nvim_create_autocmd("LspProgress", {
						---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
						callback = function(ev)
							local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
							vim.notify(vim.lsp.status(), "info", {
								id = "lsp_progress",
								title = "LSP Progress",
								opts = function(notif)
									notif.icon = ev.data.params.value.kind == "end" and " "
										or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
								end,
							})
						end,
					})
				end,
			},
			{
				"chrisgrieser/nvim-lsp-endhints",
				event = "LspAttach",
				opts = {},
			},
		},
	},
}
