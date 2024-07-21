return {
	"nvim-telescope/telescope.nvim",
	-- tag = "0.1.6",
	branch = "0.1.x",
	cmd = { "Telescope" },
	config = function()
		local tl = require("telescope")
		local actions = require("telescope.actions")

		tl.setup({
			defaults = {
				mappings = {
					i = {
						["<esc>"] = actions.close,
						["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
					},
					n = {
						["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
					},
				},
			},
			extensions = {
				smart_open = {
					match_algorithm = "fzf",
				},
			},
		})
		tl.load_extension("projects")
		tl.load_extension("fzf")
		tl.load_extension("recent_files")
		tl.load_extension("smart_open")
	end,
	keys = function()
		local telescope = require("telescope.builtin")
		return {
			{
				"<leader><leader>",
				function()
					require("telescope").extensions.smart_open.smart_open({ filename_first = false })
				end,
			},
			{ "<leader>pf", telescope.find_files },
			{ "<C-p>", telescope.git_files },
			{ "<leader>b", telescope.buffers },
			{ "<leader>pg", telescope.live_grep },
			{ "<leader>pp", require("telescope").extensions.projects.projects },
			{ "<leader>pr", require("telescope").extensions.recent_files.pick },
			{ "<leader>ph", telescope.command_history },
			{ "<leader>pq", telescope.quickfix },
			{ "<leader>pt", telescope.treesitter },
			{ "<leader>pc", telescope.colorscheme },
		}
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"ahmedkhalf/project.nvim",
		"smartpde/telescope-recent-files",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{ "danielfalk/smart-open.nvim", dependencies = { "kkharji/sqlite.lua" } },
	},
}
