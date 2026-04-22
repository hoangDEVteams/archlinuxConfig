local M = {}

table.insert(M, {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = "Telescope",
	keys = function()
		local builtin = require("telescope.builtin")
		return {
			{ "<leader>tf", builtin.find_files },
			{ "<leader>tg", builtin.git_files },
			{ "<leader>tk", builtin.keymaps },
			{ "<leader>bf", builtin.buffers },
			{ "<leader>lg", builtin.live_grep },
			{ "<leader>of", builtin.oldfiles },
			{ "<leader>rs", builtin.resume },
		}
	end,
	opts = {
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
		},
	},
})

table.insert(M, {
	"nvim-telescope/telescope-fzf-native.nvim",
	build = "make",
	dependencies = { "nvim-telescope/telescope.nvim" },
	config = function()
		require("telescope").load_extension("fzf")
	end,
})

return M
