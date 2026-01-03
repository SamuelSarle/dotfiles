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

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSUpdate" },
		event = "UIEnter",
		config = function()
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
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		opts = {
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
		},
		keys = {
			{
				"am",
				mode = { "x", "o" },
				function()
					require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
				end,
				desc = "Function",
			},
			{
				"im",
				mode = { "x", "o" },
				function()
					require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
				end,
				desc = "Function",
			},
			{
				"ac",
				mode = { "x", "o" },
				function()
					require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
				end,
				desc = "Class",
			},
			{
				"ic",
				mode = { "x", "o" },
				function()
					require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
				end,
				desc = "Class",
			},
			{
				"as",
				mode = { "x", "o" },
				function()
					require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
				end,
				desc = "Scope",
			},

			{
				"]m",
				mode = { "n", "x", "o" },
				function()
					require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
				end,
				desc = "Function",
			},
			{
				"[m",
				mode = { "n", "x", "o" },
				function()
					require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
				end,
				desc = "Function",
			},

			{
				"]c",
				mode = { "n", "x", "o" },
				function()
					require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
				end,
				desc = "Class",
			},
			{
				"[c",
				mode = { "n", "x", "o" },
				function()
					require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
				end,
				desc = "Class",
			},
		},
	},
}
