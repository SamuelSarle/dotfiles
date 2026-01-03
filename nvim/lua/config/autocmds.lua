vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

-- https://github.com/ThorstenRhau/neovim/blob/845145416a97fccbc8fd1b4c9940cff9bce2d247/lua/config/autocmd.lua#L185

-- Disable persistent undo for sensitive files
local sensitive_patterns = {
	-- Temp directories
	"/tmp/*",
	"/private/tmp/*", -- macOS
	"$TMPDIR/*",
	"/var/tmp/*",

	-- Environment files
	".env",
	".env.*",
	"*.env",
	"*/.env",
	"*/.env.*",

	-- SSH and GPG
	"*/.ssh/*",
	"*/.gnupg/*",

	-- Credentials and keys
	"*_rsa",
	"*_ed25519",
	"*_ecdsa",
	"*_dsa",
	"*.pem",
	"*.key",
	"*.p12",
	"*.pfx",
	"*.crt",
	"*.cer",

	-- Password managers
	"/dev/shm/*", -- pass, gopass use this
}

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	group = vim.api.nvim_create_augroup("no_undo_sensitive", { clear = true }),
	pattern = sensitive_patterns,
	desc = "Disable undofile for sensitive paths",
	callback = function()
		vim.bo.undofile = false
	end,
})

-- Clean old undo files (older than 60 days) with delayed startup
vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("undo_cleanup", { clear = true }),
	desc = "Clean old undo files after delay",
	callback = function()
		vim.defer_fn(function()
			if vim.o.undodir == "" then
				return
			end

			local max_age_days = 60
			local max_age_seconds = max_age_days * 24 * 60 * 60
			local now = os.time()
			local total_deleted = 0

			for _, dir in ipairs(vim.split(vim.o.undodir, ",", { trimempty = true })) do
				local undodir = vim.fn.expand(dir)

				-- Safety: only proceed if path contains 'undo' and exists
				if undodir:match("undo") and vim.fn.isdirectory(undodir) == 1 then
					local handle = (vim.uv or vim.loop).fs_scandir(undodir)
					if handle then
						while true do
							local name, type = (vim.uv or vim.loop).fs_scandir_next(handle)
							if not name then
								break
							end

							-- Safety: only delete files that look like undo files (path-encoded with %)
							if type == "file" and name:match("%%") then
								local filepath = vim.fs.joinpath(undodir, name)
								local stat = (vim.uv or vim.loop).fs_stat(filepath)
								if stat and (now - stat.mtime.sec) > max_age_seconds then
									local ok, err = (vim.uv or vim.loop).fs_unlink(filepath)
									if not ok then
										vim.notify("Failed to delete " .. name .. ": " .. err, vim.log.levels.WARN)
									else
										total_deleted = total_deleted + 1
									end
								end
							end
						end
					end
				end
			end

			if total_deleted > 0 then
				vim.notify(string.format("Cleaned %d old undo file(s)", total_deleted), vim.log.levels.DEBUG)
			end
		end, 5000)
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	desc = "Highlight yanked text",
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("LspProgress", {
	group = vim.api.nvim_create_augroup("lspprogress_spinner", { clear = true }),
	callback = function(ev)
		local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
		vim.notify(vim.lsp.status(), "info", {
			id = "lsp_progress",
			title = "LSP Progress",
			opts = function(notif)
				notif.icon = ev.data.params.value.kind == "end" and " "
					or spinner[math.floor((vim.uv or vim.loop).hrtime() / (1e6 * 80)) % #spinner + 1]
			end,
		})
	end,
})

local lspattach_group = vim.api.nvim_create_augroup("lspattach_group", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
	group = lspattach_group,
	desc = "LSP actions",
	callback = function(event)
		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = event.buf
			vim.keymap.set(mode, l, r, opts)
		end

		map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
		map("n", "gD", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
		map("n", "gk", vim.diagnostic.open_float, { desc = "Open diagnostic" })

		vim.api.nvim_create_autocmd("CursorHold", {
			group = lspattach_group,
			buffer = event.buf,
			callback = function()
				vim.diagnostic.config({ virtual_lines = { current_line = true } })
			end,
			desc = "Enable virtual_lines with current_line",
		})

		vim.api.nvim_create_autocmd("CursorMoved", {
			group = lspattach_group,
			buffer = event.buf,
			callback = function()
				vim.diagnostic.config({ virtual_lines = false })
			end,
			desc = "Disable virtual_lines",
		})
	end,
})
