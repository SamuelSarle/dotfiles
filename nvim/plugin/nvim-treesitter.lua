vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
})

local languages = {
	"astro",
	"bash",
	"c",
	"cmake",
	"commonlisp",
	"cpp",
	"css",
	"csv",
	"dart",
	"diff",
	"dockerfile",
	"eex",
	"elixir",
	"fish",
	"git_config",
	"git_rebase",
	"gitignore",
	"go",
	"gomod",
	"gosum",
	"gotmpl",
	"gowork",
	"haskell",
	"heex",
	"helm",
	"html",
	"javascript",
	"jsdoc",
	"json",
	"json5",
	"jsonc",
	"jsx",
	"just",
	"latex",
	"lua",
	"luadoc",
	"make",
	"markdown",
	"markdown_inline",
	"nginx",
	"nix",
	"ocaml",
	"ocaml_interface",
	"python",
	"regex",
	"ruby",
	"rust",
	"scheme",
	"sparql",
	"sql",
	"ssh_config",
	"svelte",
	"swift",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"xml",
	"yaml",
	"zig",
	"zsh",
}

local group = vim.api.nvim_create_augroup("treesitter.setup", { clear = true })

vim.api.nvim_create_autocmd("User", {
	group = group,
	pattern = "BufReadPost",
	once = true,
	callback = function()
		-- replicate `ensure_installed`, runs asynchronously, skips existing languages
		require("nvim-treesitter").install(languages)
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = group,
	callback = function(args)
		local buf = args.buf
		local filetype = args.match

		-- you need some mechanism to avoid running on buffers that do not
		-- correspond to a language (like oil.nvim buffers), this implementation
		-- checks if a parser exists for the current language
		local language = vim.treesitter.language.get_lang(filetype) or filetype
		if not vim.treesitter.language.add(language) then
			return
		end

		vim.wo.foldmethod = "expr"
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

		vim.treesitter.start(buf, language)

		vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	group = group,
	callback = function(args)
		require("nvim-treesitter-textobjects").setup({
			select = {
				-- Automatically jump forward to textobj, similar to targets.vim
				lookahead = true,
				-- You can choose the select mode (default is charwise 'v')
				--
				-- Can also be a function which gets passed a table with the keys
				-- * query_string: eg '@function.inner'
				-- * method: eg 'v' or 'o'
				-- and should return the mode ('v', 'V', or '<c-v>') or a table
				-- mapping query_strings to modes.
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
					["@class.outer"] = "<c-v>", -- blockwise
				},
			},
		})

		local buf = args.buf
		vim.keymap.set({ "x", "o" }, "am", function()
			require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
		end, { buf = buf, desc = "Function" })

		vim.keymap.set({ "x", "o" }, "im", function()
			require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
		end, { buf = buf, desc = "Function" })

		vim.keymap.set({ "x", "o" }, "ac", function()
			require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
		end, { buf = buf, desc = "Class" })

		vim.keymap.set({ "x", "o" }, "ic", function()
			require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
		end, { buf = buf, desc = "Class" })

		vim.keymap.set({ "x", "o" }, "as", function()
			require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
		end, { buf = buf, desc = "Scope" })

		vim.keymap.set({ "n", "x", "o" }, "]m", function()
			require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
		end, { buf = buf, desc = "Function" })

		vim.keymap.set({ "n", "x", "o" }, "[m", function()
			require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
		end, { buf = buf, desc = "Function" })

		vim.keymap.set({ "n", "x", "o" }, "]c", function()
			require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
		end, { buf = buf, desc = "Class" })

		vim.keymap.set({ "n", "x", "o" }, "[c", function()
			require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
		end, { buf = buf, desc = "Class" })
	end,
})
