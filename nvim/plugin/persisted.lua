vim.pack.add({ "https://github.com/olimorris/persisted.nvim" })

vim.api.nvim_create_autocmd("BufReadPre", {
	callback = function()
		require("persisted").setup()
	end,
})

vim.keymap.set("n", "<leader>qs", function()
	require("persisted").load()
end, { desc = "Load the session for the current directory" })

vim.keymap.set("n", "<leader>qS", function()
	require("persisted").select()
end, { desc = "Select a session to load" })

vim.keymap.set("n", "<leader>ql", function()
	require("persisted").load({ last = true })
end, { desc = "Load the last session" })

vim.keymap.set("n", "<leader>qd", function()
	require("persisted").stop()
end, { desc = "Stop Persistence: session won't be saved on exit" })
