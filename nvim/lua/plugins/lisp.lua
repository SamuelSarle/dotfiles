return {
	{
		"kovisoft/slimv",
		ft = { "lisp" },
		config = function()
			vim.g.paredit_mode = 0
			vim.g.lisp_rainbow = 1
		end,
	},
	{
		"gpanders/nvim-parinfer",
		ft = { "lisp" },
	},
}
