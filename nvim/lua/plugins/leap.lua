return {
	"ggandor/leap.nvim",
	config = function()
		local l = require("leap")
		l.add_default_mappings()
		vim.keymap.set("n", "gs", function()
			l.leap({ target_windows = { vim.fn.win_getid() } })
		end)
	end,
	keys = { "s", "S", "gs" },
	dependencies = "tpope/vim-repeat",
}
