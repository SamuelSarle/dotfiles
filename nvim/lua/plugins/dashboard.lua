return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = function()
		local dashboard = require("alpha.themes.dashboard")

		local function info()
			local stats = require("lazy").stats()
			local ms = math.floor(stats.startuptime * 100) / 100
			local v = vim.version()
			local datetime = os.date(" %Y-%m-%d   %H:%M:%S")
			return string.format(
				"V%d.%d.%d  󰂖 Loaded %d / %d plugins in %d ms  %s",
				v.major,
				v.minor,
				v.patch,
				stats.loaded,
				stats.count,
				ms,
				datetime
			)
		end

		local function button(key, label, action)
			local opts = {
				cursor = 3,
				hl = "String",
				hl_shortcut = "Keyword",
				align_shortcut = "right",
				position = "center",
				width = 35,
				shortcut = key,
				keymap = {
					"n",
					key,
					action,
					{ noremap = true, silent = true, nowait = true },
				},
			}
			local function on_press()
				local key = vim.api.nvim_replace_termcodes(action .. "<Ignore>", true, false, true)
				vim.api.nvim_feedkeys(key, "t", false)
			end
			return { type = "button", val = label, on_press = on_press, opts = opts }
		end

		local buttons = {
			button("n", "  New file", "<cmd>ene<cr>"),
			button("p", "  Projects", "<cmd>lua Snacks.picker.projects()<cr>"),
			button("r", "  Recents", "<cmd>lua Snacks.picker.recent()<cr>"),
			button("g", "󰈞  Find Text", "<cmd>lua Snacks.picker.grep()<cr>"),
			button("d", "  Dotfiles", "<cmd>lua Snacks.picker.files({ cwd = '~/Projects/dotfiles' })<cr>"),
			button("u", "󰊳  Update", "<cmd>Lazy update<cr>"),
			button("l", "󰒲  Lazy", "<cmd>Lazy<cr>"),
			button("m", "󱌣  Mason", "<cmd>Mason<cr>"),
			button("q", "  Quit", "<cmd>qa!<cr>"),
		}

		dashboard.section.footer.opts.hl = "Comment"

		local layout = {
			dashboard.section.header,
			{ type = "padding", val = 2 },
			{ type = "group", val = buttons, opts = { spacing = 1 } },
			{ type = "padding", val = 2 },
			dashboard.section.footer,
		}

		vim.api.nvim_create_autocmd("User", {
			callback = function()
				dashboard.section.footer.val = info()
				pcall(vim.cmd.AlphaRedraw)
			end,
		})

		if vim.o.filetype == "lazy" then
			vim.cmd.close()
			vim.api.nvim_create_autocmd("User", {
				pattern = "AlphaReady",
				callback = function()
					require("lazy").show()
				end,
			})
		end

		return { layout = layout }
	end,
}
