vim.opt.copyindent = true
vim.opt.cursorline = true
vim.opt.encoding = "utf-8"
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.gdefault = true
vim.opt.guicursor = "n-v-c-sm-t:block-blinkon500-blinkoff500-Cursor/lCursor,i-ci-ve:ver25-blinkon500-blinkoff500"
vim.opt.inccommand = "split"
vim.opt.jumpoptions = "stack,view"
vim.opt.laststatus = 3
vim.opt.lazyredraw = true
vim.opt.list = true
vim.opt.listchars = { eol = "¬", tab = "› ", trail = "~", extends = ">", nbsp = "•" }
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.sessionoptions:remove("blank")
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.timeout = false
vim.opt.title = true
vim.opt.titlestring = "%<%F - nvim"
vim.opt.updatetime = 500
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.winborder = "single"

vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.smartcase = true

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undodir"
vim.opt.undofile = true
vim.opt.undolevels = 5000

vim.opt.expandtab = false
vim.opt.shiftround = false
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
