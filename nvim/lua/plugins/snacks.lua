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
					{
						icon = " ",
						key = "f",
						desc = "Find File",
						action = "<cmd>lua Snacks.dashboard.pick('files')<cr>",
					},
					{
						icon = " ",
						key = "g",
						desc = "Find Text",
						action = "<cmd>lua Snacks.dashboard.pick('live_grep')<cr>",
					},
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = "<cmd>lua Snacks.dashboard.pick('oldfiles')<cr>",
					},
					{
						icon = " ",
						key = "d",
						desc = "Dotfiles",
						action = "<cmd>lua Snacks.dashboard.pick('files', {cwd = '~/Projects/dotfiles'})<cr>",
					},
					{
						icon = "󰒲 ",
						key = "l",
						desc = "Lazy",
						action = "<cmd>Lazy<cr>",
						enabled = package.loaded.lazy ~= nil,
					},
					{
						icon = "󱌣 ",
						key = "m",
						desc = "Mason",
						action = "<cmd>Mason<cr>",
					},
					{ icon = " ", key = "q", desc = "Quit", action = "<cmd>qa<cr>" },
				},
			},
			sections = {
				{ section = "header" },
				{ section = "keys", padding = 2 },
				{
					icon = " ",
					title = "Recent Files",
					section = "recent_files",
					indent = 2,
					padding = 2,
				},
				{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
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
