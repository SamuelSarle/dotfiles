vim.pack.add({ "https://github.com/zbirenbaum/copilot.lua" })

-- vim.api.nvim_create_autocmd("InsertEnter", {
-- 	once = true,
-- 	callback = function()
-- 		require("copilot").setup({
-- 			suggestion = {
-- 				auto_trigger = false,
-- 			},
-- 			filetypes = {
-- 				["*"] = false,
-- 			},
-- 		})
-- 	end,
-- })
--
-- vim.keymap.set("n", "<leader>c", "<cmd>Copilot! attach<cr>", { desc = "Copilot attach" })
