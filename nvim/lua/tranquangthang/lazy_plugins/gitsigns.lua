return {
	"lewis6991/gitsigns.nvim",
	event = "BufEnter",
	opts = { preview_config = { border = "rounded" } },
	keys = function()
		local gitsigns_actions = require("gitsigns.actions")

		return {
			{ "<leader>hs", gitsigns_actions.stage_hunk },
			{ "<leader>hr", gitsigns_actions.reset_hunk },
			{ "<leader>hS", gitsigns_actions.stage_buffer },
			{ "<leader>hR", gitsigns_actions.reset_buffer },
			{ "<leader>hp", gitsigns_actions.preview_hunk },
			{ "<leader>tb", gitsigns_actions.toggle_current_line_blame },
			{ "<leader>td", gitsigns_actions.preview_hunk_inline },
			{ "<leader>hd", gitsigns_actions.diffthis },
			{
				"<leader>hD",
				function()
					gitsigns_actions.diffthis("~")
				end,
			},
			{
				"<leader>hb",
				function()
					gitsigns_actions.blame_line({ full = true })
				end,
			},
			{
				"]g",
				function()
					if vim.wo.diff then
						vim.cmd.normal({ "]g", bang = true })
					else
						gitsigns_actions.nav_hunk("next")
					end
				end,
			},
			{
				"[g",
				function()
					if vim.wo.diff then
						vim.cmd.normal({ "[g", bang = true })
					else
						gitsigns_actions.nav_hunk("prev")
					end
				end,
			},
			{
				"<leader>hs",
				function()
					gitsigns_actions.stage_hunk({
						vim.fn.line("."),
						vim.fn.line("v"),
					})
				end,
				mode = "x",
			},
			{
				"<leader>hr",
				function()
					gitsigns_actions.reset_hunk({
						vim.fn.line("."),
						vim.fn.line("v"),
					})
				end,
				mode = "x",
			},
			{ "ih", gitsigns_actions.select_hunk, mode = { "o", "x" } },
		}
	end,
}
