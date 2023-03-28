vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", { defaults = { lazy = true } })

vim.cmd.colorscheme("github_dark_default")

vim.opt.updatetime = 500
vim.opt.termguicolors = true
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undolevels = 5000
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
vim.opt.undofile = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.gdefault = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.encoding = "utf-8"
vim.opt.cursorline = true
vim.opt.timeout = false
vim.opt.list = true
vim.opt.listchars = { eol = "¬", tab = "› ", trail = "~", extends = ">", nbsp = "•" }

local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWritePre", {
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

vim.keymap.set("n", "<leader>s", vim.cmd.w)
vim.keymap.set({ "n", "v" }, "j", "gj")
vim.keymap.set({ "n", "v" }, "k", "gk")

vim.keymap.set({ "n", "v" }, "<leader>p", '"+p')
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')

vim.keymap.set({ "n", "x" }, "v", "<C-v>")
vim.keymap.set({ "n", "x" }, "<C-v>", "v")

vim.keymap.set("n", "q:", ":q")

local testaug = vim.api.nvim_create_augroup("TestMaps", { clear = true })
autocmd("Filetype", {
	group = testaug,
	pattern = "go",
	callback = function()
		local opts = { buffer = true }
		vim.keymap.set("n", ",ta", ":!go test -cover ./...<CR>", opts)
		vim.keymap.set(
			"n",
			",tc",
			":!go test -coverprofile=c.out ./... && go tool cover -html=c.out && unlink c.out",
			opts
		)
		vim.keymap.set("n", ",tp", function()
			vim.cmd("!go test -cover " .. vim.fn.expand("%:p:h") .. "/")
		end, opts)
	end,
})
