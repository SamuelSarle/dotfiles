return {
	"mbbill/undotree",
	keys = {
		{ "<leader>u", vim.cmd.UndotreeShow, desc = "Show Undotree" },
	},
	config = function()
		vim.g.undotree_SetFocusWhenToggle = 1
	end,
}
