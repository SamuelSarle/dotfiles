return {
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = "nvim-treesitter/nvim-treesitter",
		cmd = { "TSContextEnable", "TSContextDisable", "TSContextToggle" },
		ft = { "go", "rust", "lua", "python", "javascript", "typescript" },
		config = function()
			require("treesitter-context").setup({})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable" },
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"help",
					"javascript",
					"typescript",
					"c",
					"lua",
					"nix",
					"go",
					"gomod",
					"svelte",
					"rust",
				},
				sync_install = false,
				auto_install = false,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			})
		end,
	},
}
