return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = {},
		input = {},
		notifier = {},
		picker = {},
		quickfile = {},
		dashboard = {
			preset = {
				keys = {
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
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
							vim.fn.chdir("~/Projects/dotfiles")
							Snacks.picker.smart()
						end,
					},
					{
						icon = "󰒲 ",
						key = "l",
						desc = "Lazy",
						action = function()
							require("lazy"):show()
						end,
						enabled = package.loaded.lazy ~= nil,
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
				{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
				{
					icon = " ",
					title = "Recent Files",
					section = "recent_files",
					indent = 2,
					padding = 2,
				},
				{ section = "startup" },
			},
		},
	},
	keys = {
		{
			"<leader><leader>",
			function()
				Snacks.picker.smart()
			end,
			desc = "Smart Files",
		},
		{
			"<leader>/",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>b",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Files",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.git_files()
			end,
			desc = "Git Files",
		},
		{
			"<leader>fp",
			function()
				Snacks.picker.projects()
			end,
			desc = "Projects",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.recent()
			end,
			desc = "Recent",
		},
		{
			"<leader>fs",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},
		{
			"<leader>fS",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "LSP Workspace Symbols",
		},
	},
}
