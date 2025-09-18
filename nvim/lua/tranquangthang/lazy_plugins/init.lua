local M = {
	"tpope/vim-obsession",
	"habamax/vim-godot",
	"ThePrimeagen/vim-be-good",
	{
		"laytan/cloak.nvim",
		opts = {},
	},
	{
		"eduardo-antunes/plainline",
		opts = {},
	},
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
	},
}

table.insert(M, {
	"mbbill/undotree",
	cmd = "UndoTreeToggle",
	keys = { { "<leader>u", "<cmd>UndotreeToggle<CR>" } },
})

table.insert(M, {
	"prichrd/netrw.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {},
})

table.insert(M, {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = true,
})

table.insert(M, {
	"kylechui/nvim-surround",
	event = "VeryLazy",
	config = true,
})

table.insert(M, {
	"m4xshen/hardtime.nvim",
	dependencies = { "MunifTanjim/nui.nvim", "j-hui/fidget.nvim" },
	opts = {
		callback = function(text)
			require("fidget").notify(text, vim.log.levels.WARN, {
				group = "Hardtime",
				ttl = require("hardtime.config").config.timeout / 1000,
			})
		end,
	},
})

table.insert(M, {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			gdscript = { "gdformat" },
			html = { "prettierd" },
			css = { "prettierd" },
			json = { "prettierd" },
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			bash = { "shfmt" },
			nix = { "nixfmt" },
			templ = { "templ" },
			cs = { "csharpier" },
		},
	},
})

table.insert(M, {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	keys = function()
		local harpoon = require("harpoon")
		local ui = harpoon.ui
		local list = harpoon:list()

		local keys = {
			{
				"<leader>a",
				function()
					list:add()
				end,
			},
			{
				"<leader>m",
				function()
					ui:toggle_quick_menu(list)
				end,
			},
			{
				"<C-l>",
				function()
					list:next()
				end,
			},
			{
				"<C-h>",
				function()
					list:prev()
				end,
			},
		}

		for i = 1, 9 do
			table.insert(keys, {
				"<leader>" .. i,
				function()
					list:select(i)
				end,
			})
		end

		return keys
	end,
	config = function()
		local extensions = require("harpoon.extensions")
		local harpoon = require("harpoon")
		harpoon:extend(extensions.builtins.navigate_with_number())
		harpoon:extend(extensions.builtins.highlight_current_file())
	end,
})

table.insert(M, {
	"catgoose/nvim-colorizer.lua",
	opts = {
		filetypes = {
			"html",
			"css",
			"javascript",
			"typescript",
			cmp_menu = { always_update = true },
			cmp_docs = { always_update = true },
		},
		user_default_options = {
			names = false,
			rgb_fn = true,
			hsl_fn = true,
			css = true,
			css_fn = true,
			tailwind = "both",
			tailwind_opts = {
				update_names = true,
			},
		},
	},
})

table.insert(M, {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		default_file_explorer = false,
		view_options = { show_hidden = true },
	},
	cmd = "Oil",
	keys = {
		{
			"<leader>-",
			function()
				require("oil").setup({
					view_options = { show_hidden = true },
				})
				local file_pattern =
					vim.fn.escape(vim.fn.expand("%:t"), [[\/.*~]])
				vim.cmd.Oil()
				vim.fn.search(file_pattern)
			end,
		},
	},
})

table.insert(M, {
	"tpope/vim-fugitive",
	cmd = { "G", "Git" },
	keys = {
		{ "<leader>gs", "<cmd>Git<CR>" },
		{ "gh", "<cmd>diffget //2<CR>" },
		{ "gl", "<cmd>diffget //3<CR>" },
	},
})

table.insert(M, {
	"folke/todo-comments.nvim",
	dependencies = "nvim-lua/plenary.nvim",
	lazy = false,
	config = true,
	keys = function()
		local jump = require("todo-comments.jump")
		return {
			{ "<leader>ttf", "<cmd>TodoTelescope<CR>" },
			{ "<leader>txx", "<cmd>TodoTrouble<CR>" },
			{ "]t", jump.next },
			{ "[t", jump.prev },
		}
	end,
})

return M
