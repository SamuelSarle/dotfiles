return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	config = function()
		local lsp_zero = require("lsp-zero")
		lsp_zero.extend_cmp()

		local luasnip = require("luasnip")
		local cmp = require("cmp")

		cmp.setup({
			formatting = lsp_zero.cmp_format({ details = true }),
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				["<C-K>"] = cmp.mapping(function(fallback) -- Expand luasnip, no matter what is currently selected
					if luasnip.expandable() then
						luasnip.expand()
					else
						fallback()
					end
				end),

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
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			}, {
				{ name = "buffer" },
			}),
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
		})
		require("luasnip.loaders.from_vscode").lazy_load()
	end,
	dependencies = {
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",

		-- Snippets
		{ "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jseregexp" },
		"rafamadriz/friendly-snippets",
		"saadparwaiz1/cmp_luasnip",
	},
}
