return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.1",
	config = function()
		local tl = require("telescope")
		local actions = require("telescope.actions")
		local trouble = require("trouble.providers.telescope")

		tl.setup({
			defaults = {
				mappings = {
					i = {
						["<c-t>"] = trouble.open_with_trouble,
						["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
					},
					n = {
						["<c-t>"] = trouble.open_with_trouble,
						["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
					},
				},
			},
		})
		tl.load_extension("projects")
		tl.load_extension("fzf")
	end,
	keys = function()
		local telescope = require("telescope.builtin")
		return {
			{ "<leader>pf", telescope.find_files },
			{
				"<leader>pr",
				function()
					telescope.find_files({ cwd = vim.fn.expand("~/repos/") })
				end,
			},
			{ "<C-p>", telescope.git_files },
			{ "<leader>pg", telescope.live_grep },
			{ "<leader>pp", require("telescope").extensions.projects.projects },
			{ "<leader>pb", telescope.buffers },
			{ "<leader>ph", telescope.command_history },
		}
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"folke/trouble.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
}
