return {
	"stevearc/oil.nvim",
	opts = {
		keymaps = {
			["q"] = "actions.close",
		},
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = { "Oil" },
	keys = {
		{
			"<leader>d",
			function()
				require("oil").open_float()
			end,
			desc = "Open oil",
		},
		{
			"<leader>D",
			function()
				require("oil").open()
			end,
			desc = "Open oil",
		},
	},
	init = function()
		if vim.fn.argc() == 1 then
			local argv = vim.fn.argv(0) --[[@as string]]
			local stat = vim.uv.fs_stat(argv)
			if stat and stat.type == "directory" then
				require("lazy").load({ plugins = { "oil.nvim" } })
			end
		end
	end,
}
