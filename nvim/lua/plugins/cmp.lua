return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	config = function()
		local luasnip = require("luasnip")
		local cmp = require("cmp")
		cmp.setup({
			mapping = {
				["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

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
	end,
	dependencies = {
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",

		-- Snippets
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
	},
}
