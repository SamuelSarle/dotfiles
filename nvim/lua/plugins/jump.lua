return {
	{
		"cbochs/portal.nvim",
		dependencies = {
			"cbochs/grapple.nvim",
		},
		opts = {
			window_options = {
				height = 5,
			},
		},
		keys = {
			{
				"<A-g>",
				function()
					require("portal.builtin").grapple.tunnel_forward()
				end,
			},
			{
				"<A-i>",
				function()
					require("portal.builtin").jumplist.tunnel_forward()
				end,
			},
			{
				"<A-o>",
				function()
					require("portal.builtin").jumplist.tunnel_backward()
				end,
			},
			{
				"<A-c>",
				function()
					require("portal.builtin").changelist.tunnel_forward()
				end,
			},
		},
	},
	{
		"cbochs/grapple.nvim",
		opts = {
			scope = "global",
		},
		keys = {
			{ "<C-e>", "<cmd>GrapplePopup tags<cr>" },
			{
				"<leader>a",
				function()
					require("grapple").toggle()
				end,
			},
			{
				"<A-j>",
				function()
					require("grapple").select({ key = 1 })
				end,
			},
			{
				"<A-k>",
				function()
					require("grapple").select({ key = 2 })
				end,
			},
			{
				"<A-l>",
				function()
					require("grapple").select({ key = 3 })
				end,
			},
			{
				"<A-;>",
				function()
					require("grapple").select({ key = 4 })
				end,
			},
			{
				"<A-r>",
				function()
					require("grapple").reset()
				end,
			},
			{
				"<A-q>",
				function()
					require("grapple").cycle_forward()
				end,
			},
			{
				"<A-Q>",
				function()
					require("grapple").cycle_backward()
				end,
			},
		},
		dependencies = { "nvim-lua/plenary.nvim" },
	},
}
