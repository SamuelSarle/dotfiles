vim.pack.add({ "https://github.com/folke/which-key.nvim" })

vim.api.nvim_create_autocmd("UIEnter", {
	once = true,
	callback = function()
		require("which-key").setup({
			preset = "helix",
			filter = function(mapping)
				return mapping.desc and mapping.desc ~= ""
			end,
			expand = 2,
			spec = {
				{ "<leader>f", group = "Find" },
				{ "<leader>h", group = "Git" },
				{ "<leader>o", group = "Overseer" },
			},
		})
		vim.keymap.set("n", "<leader>?", function()
			require("which-key").show({ global = false })
		end, { desc = "Buffer Local Keymaps (which-key)" })
	end,
})
