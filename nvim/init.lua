pcall(require, "impatient")
vim.cmd.packadd("packer.nvim")
require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("lewis6991/impatient.nvim")
	use({
		"bluz71/vim-moonfly-colors",
		config = function()
			vim.cmd.colorscheme("moonfly")
		end,
	})
	use({ "nvim-telescope/telescope.nvim", tag = "0.1.0", requires = { { "nvim-lua/plenary.nvim" } } })
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use({ "nvim-tree/nvim-tree.lua", tag = "nightly" })
	use("mbbill/undotree")
	use("nvim-tree/nvim-web-devicons")
	use("tpope/vim-commentary")
	use("tpope/vim-fugitive")
	use({
		"akinsho/git-conflict.nvim",
		config = function()
			require("git-conflict").setup()
		end,
	})
	use("tpope/vim-surround")
	use("tpope/vim-unimpaired")
	use("ThePrimeagen/harpoon")
	use("arkav/lualine-lsp-progress")
	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				sections = { lualine_c = { "lsp_progress" } },
				options = { icons_enabled = false, theme = "moonfly" },
			})
		end,
	})
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({
				detection_methods = { "pattern", "lsp" },
				scope_chdir = "win",
			})
		end,
	})
	use({
		"ggandor/leap.nvim",
		config = function()
			local l = require("leap")
			l.add_default_mappings()
			vim.keymap.set("n", "gs", function()
				l.leap({ target_windows = { vim.fn.win_getid() } })
			end)
		end,
	})
	use("jose-elias-alvarez/null-ls.nvim")
	use({
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	})
end)

require("telescope").load_extension("projects")
require("telescope").load_extension("fzf")

require("nvim-treesitter.configs").setup({
	ensure_installed = { "help", "javascript", "typescript", "c", "lua", "nix", "go", "svelte" },
	sync_install = false,
	auto_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})

local luasnip = require("luasnip")
local cmp = require("cmp")
cmp.setup({
	mapping = {
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
})

local lsp = require("lsp-zero")
lsp.preset("recommended")
lsp.ensure_installed({
	"tsserver",
	"eslint",
	"sumneko_lua",
	"gopls",
	"svelte",
	"tailwindcss",
})
lsp.set_preferences({
	suggest_lsp_servers = false,
	sign_icons = {
		error = "E",
		warn = "W",
		hint = "H",
		info = "I",
	},
})
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
	vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({
					bufnr = bufnr,
					filter = function(client)
						return client.name == "null-ls"
					end,
				})
			end,
		})
	end
end)
lsp.nvim_workspace()
lsp.setup()
vim.diagnostic.config({
	virtual_text = true,
})

local null_opts = lsp.build_options("null-ls", {})
require("null-ls").setup({
	on_attach = null_opts.on_attach,
	sources = {
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.formatting.gofumpt,
		require("null-ls").builtins.formatting.golines,
		require("null-ls").builtins.formatting.goimports,
		require("null-ls").builtins.formatting.prettierd.with({ extra_filetypes = { "svelte" } }),
	},
})

require("nvim-tree").setup({
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = true,
	},
})

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

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>s", vim.cmd.w)
vim.keymap.set({ "n", "v" }, "j", "gj")
vim.keymap.set({ "n", "v" }, "k", "gk")

vim.keymap.set({ "n", "v" }, "<leader>p", '"+p')
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')

vim.keymap.set({ "n", "x" }, "v", "<C-v>")
vim.keymap.set({ "n", "x" }, "<C-v>", "v")

vim.keymap.set("n", "<leader>g", vim.cmd.Git)
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<leader>t", vim.cmd.NvimTreeToggle)

vim.keymap.set("n", "q:", ":q")

local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>pf", telescope.find_files)
vim.keymap.set("n", "<leader>pr", function()
	telescope.find_files({ cwd = vim.fn.expand("~/repos/") })
end)
vim.keymap.set("n", "<C-p>", telescope.git_files)
vim.keymap.set("n", "<leader>pg", telescope.live_grep)
vim.keymap.set("n", "<leader>pp", require("telescope").extensions.projects.projects)
vim.keymap.set("n", "<leader>pb", telescope.buffers)
vim.keymap.set("n", "<leader>ph", telescope.command_history)

vim.keymap.set("n", "q:", ":q")

local testaug = vim.api.nvim_create_augroup("TestMaps", { clear = true })
autocmd("Filetype", {
	group = testaug,
	pattern = "go",
	callback = function()
		local opts = { buffer = true }
		vim.keymap.set("n", ",ta", ":!go test -cover ./...<CR>", opts)
		vim.keymap.set("n", ",tp", function()
			vim.cmd("!go test -cover " .. vim.fn.expand("%:p:h") .. "/")
		end, opts)
	end,
})

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local term = require("harpoon.term")
vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
vim.keymap.set("n", "<A-t>", function()
	term.gotoTerminal(1)
end)
vim.keymap.set({ "n", "t" }, "<A-j>", function()
	ui.nav_file(1)
end)
vim.keymap.set({ "n", "t" }, "<A-k>", function()
	ui.nav_file(2)
end)
vim.keymap.set({ "n", "t" }, "<A-l>", function()
	ui.nav_file(3)
end)
vim.keymap.set({ "n", "t" }, "<A-;>", function()
	ui.nav_file(4)
end)
