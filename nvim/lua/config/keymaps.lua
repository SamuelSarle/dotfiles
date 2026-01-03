vim.keymap.set("n", "<leader>s", vim.cmd.w, { desc = "Write buffer" })
vim.keymap.set({ "n", "v" }, "j", "gj")
vim.keymap.set({ "n", "v" }, "k", "gk")

vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })

vim.keymap.set({ "n", "x" }, "v", "<C-v>")
vim.keymap.set({ "n", "x" }, "<C-v>", "v")

vim.keymap.set("n", "gh", "<cmd>diffget //2<CR>", { desc = "Diffget left" })
vim.keymap.set("n", "gl", "<cmd>diffget //3<CR>", { desc = "Diffget right" })

vim.keymap.set("n", "<C-h>", "<C-W>h")
vim.keymap.set("n", "<C-j>", "<C-W>j")
vim.keymap.set("n", "<C-k>", "<C-W>k")
vim.keymap.set("n", "<C-l>", "<C-W>l")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
