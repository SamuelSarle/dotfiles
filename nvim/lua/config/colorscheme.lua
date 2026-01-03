local function set_colorscheme()
	require("nightfox")
	vim.cmd.colorscheme(vim.o.background == "light" and "dayfox" or "carbonfox")
end

local colorgroup = vim.api.nvim_create_augroup("colorgroup", { clear = true })
vim.api.nvim_create_autocmd("OptionSet", {
	pattern = "background",
	group = colorgroup,
	callback = set_colorscheme,
})
