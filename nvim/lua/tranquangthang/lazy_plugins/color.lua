local M = {}

table.insert(M, {
	"rose-pine/neovim",
	name = "rose-pine",
	opts = {
		enable = {},
		highlight_groups = {},
		groups = {},
		palette = {},
		styles = { transparency = true },
		before_highlight = function() end,
		variant = "auto",
		dark_variant = "moon",
		dim_inactive_windows = false,
		extend_background_behind_borders = true,
	},
	config = function(_, opts)
		require("rose-pine").setup(opts)
	end,
})

table.insert(M, {
	"folke/tokyonight.nvim",
	opts = {
		styles = {
			comments = { italic = false },
			keywords = { italic = false },
		},
	},
})

table.insert(M, {
	"catppuccin/nvim",
	name = "catppuccin",
	opts = { transparent_background = true },
})

return M
