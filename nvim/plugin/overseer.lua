vim.pack.add({ "https://github.com/stevearc/overseer.nvim" })

require("overseer").setup({
	templates = { "builtin", "user.go" },
})

vim.keymap.set("n", "<leader>or", ":OverseerRun<CR>", { desc = "Overseer run" })
vim.keymap.set("n", "<leader>ot", ":OverseerToggle<CR>", { desc = "Overseer toggle" })
vim.keymap.set("n", "<leader>oa", ":OverseerQuickAction<CR>", { desc = "Overseer quick action" })
