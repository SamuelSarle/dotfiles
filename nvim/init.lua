vim.g.mapleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.opt.updatetime = 500
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.smartindent = true
vim.opt.copyindent = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undolevels = 5000
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
vim.opt.undofile = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.inccommand = "split"
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
vim.opt.jumpoptions = "stack,view"
vim.opt.guicursor = "n-v-c-sm-t:block-blinkon500-blinkoff500-Cursor/lCursor,i-ci-ve:ver25-blinkon500-blinkoff500"
vim.opt.laststatus = 3
vim.opt.lazyredraw = true
vim.opt.winborder = "single"

local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWritePre", {
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

vim.keymap.set("n", "<leader>s", vim.cmd.w, { desc = "Write buffer" })
vim.keymap.set({ "n", "v" }, "j", "gj")
vim.keymap.set({ "n", "v" }, "k", "gk")

vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })

vim.keymap.set({ "n", "x" }, "v", "<C-v>")
vim.keymap.set({ "n", "x" }, "<C-v>", "v")

vim.keymap.set("n", "q:", ":q")

vim.keymap.set("n", "gh", "<cmd>diffget //2<CR>")
vim.keymap.set("n", "gl", "<cmd>diffget //3<CR>")

vim.keymap.set("n", "<C-h>", "<C-W>h")
vim.keymap.set("n", "<C-j>", "<C-W>j")
vim.keymap.set("n", "<C-k>", "<C-W>k")
vim.keymap.set("n", "<C-l>", "<C-W>l")

require("lazy").setup({
	defaults = { lazy = true },
	spec = { { import = "plugins" } },
	ui = { border = "single" },
	-- install = { colorscheme = { "carbonfox" } },
	-- checker = { enabled = true },
})

local function set_colorscheme()
	require("nightfox")

	if vim.o.background == "light" then
		vim.cmd.colorscheme("dayfox")
		return
	end
	if vim.o.background == "dark" then
		vim.cmd.colorscheme("carbonfox")
		return
	end
end

local colorgroup = vim.api.nvim_create_augroup("colorgroup", { clear = true })
vim.api.nvim_create_autocmd("OptionSet", {
	pattern = "background",
	group = colorgroup,
	callback = set_colorscheme,
})
