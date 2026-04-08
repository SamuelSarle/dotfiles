vim.pack.add({ "https://github.com/folke/snacks.nvim" })

require("snacks").setup({
	bigfile = {},
	input = {},
	notifier = {},
	picker = {},
	quickfile = {},
	dashboard = {
		preset = {
			keys = {
				{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
				{
					icon = " ",
					key = "s",
					desc = "Restore a Session",
					action = function()
						require("persisted").select()
					end,
				},
				{
					icon = " ",
					key = "r",
					desc = "Recent Files",
					action = function()
						Snacks.dashboard.pick("oldfiles")
					end,
				},
				{
					icon = " ",
					key = "f",
					desc = "Find File",
					action = function()
						Snacks.dashboard.pick("files")
					end,
				},
				{
					icon = " ",
					key = "g",
					desc = "Find Text",
					action = function()
						Snacks.dashboard.pick("live_grep")
					end,
				},
				{
					icon = " ",
					key = "d",
					desc = "Dotfiles",
					action = function()
						vim.fn.chdir("~/Projects/SamuelSarle/dotfiles")
						Snacks.picker.smart()
					end,
				},
				{
					icon = " ",
					key = "q",
					desc = "Quit",
					action = function()
						vim.cmd("quitall")
					end,
				},
			},
		},
		sections = {
			{ section = "header" },
			{ section = "keys", gap = 1, padding = 2 },
			{
				icon = " ",
				title = "Recent Files",
				section = "recent_files",
				indent = 2,
				padding = 2,
			},
			{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
			-- { section = "startup" },
		},
	},
})

vim.keymap.set("n", "<leader><leader>", Snacks.picker.smart, { desc = "Smart Files" })
vim.keymap.set("n", "<leader>/", Snacks.picker.grep, { desc = "Grep" })
vim.keymap.set("n", "<leader>b", Snacks.picker.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>ff", Snacks.picker.files, { desc = "Files" })
vim.keymap.set("n", "<leader>fg", Snacks.picker.git_files, { desc = "Git Files" })
vim.keymap.set("n", "<leader>fp", Snacks.picker.projects, { desc = "Projects" })
vim.keymap.set("n", "<leader>fr", Snacks.picker.recent, { desc = "Recent" })
vim.keymap.set("n", "<leader>fs", Snacks.picker.lsp_symbols, { desc = "LSP Symbols" })
vim.keymap.set("n", "<leader>fS", Snacks.picker.lsp_workspace_symbols, { desc = "LSP Workspace Symbols" })
