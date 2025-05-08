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
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			{ "williamboman/mason.nvim", cmd = { "Mason" }, opts = { ui = { border = "rounded" } } },
			{ "williamboman/mason-lspconfig.nvim" },
		},
		config = function()
			vim.diagnostic.config({
				virtual_text = {
					virt_text_pos = "eol_right_align",
				},
				severity_sort = true,
				-- virtual_lines = { current_line = true },
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
					map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, { desc = "Search for workspace symbol" })
					map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open diagnostic" })
					-- map("n", "<leader>e", function()
					-- 	local config = vim.diagnostic.config()
					-- 	local virtual_lines = config.virtual_lines
					--
					-- 	-- Check if virtual_lines is a table with current_line property
					-- 	local enabled = type(virtual_lines) == "table" and virtual_lines.current_line
					--
					-- 	if enabled then
					-- 		vim.diagnostic.config({ virtual_lines = false })
					-- 	else
					-- 		vim.diagnostic.config({ virtual_lines = { current_line = true } })
					-- 	end
					-- end, { desc = "Open diagnostic" })
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
					"solargraph",
					"ruff",
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
