return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable" },
		config = function()
			require("nvim-treesitter.install").prefer_git = true
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"javascript",
					"typescript",
					"c",
					"lua",
					"nix",
					"go",
					"gomod",
					"svelte",
					"css",
					"rust",
				},
				sync_install = false,
				auto_install = false,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				textobjects = {
					move = {
						enable = true,
						goto_next_start = {
							["]m"] = "@function.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
						},
					},
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
				},
			})
		end,
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-textobjects" },
		},
	},
}
