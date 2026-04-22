local number = vim.wo.number
local rnu = vim.wo.rnu
local colorcolumn = vim.opt.colorcolumn
local zen_group =
	vim.api.nvim_create_augroup("tranquangthang/zen", { clear = true })

return {
	"folke/zen-mode.nvim",
	keys = function()
		local zen_mode = require("zen-mode")
		return {
			{ "<leader>zz", zen_mode.toggle },
			{
				"<leader>zZ",
				function()
					zen_mode.toggle({
						window = {
							width = 85,
							options = {
								signcolumn = "no",
								number = false,
								relativenumber = false,
								cursorline = false,
								cursorcolumn = false,
								foldcolumn = "0",
								colorcolumn = "0",
								list = false,
							},
						},
					})
				end,
			},
		}
	end,
	opts = {
		window = {
			backdrop = 0.95,
			width = 90,
			height = 1,
			options = {},
		},
		plugins = {
			options = {
				enabled = true,
				ruler = false,
				laststatus = 0,
			},
			twilight = { enabled = true },
			gitsigns = { enabled = false },
			tmux = { enabled = true },
			kitty = {
				enabled = false,
				font = "+4",
			},
			alacritty = {
				enabled = false,
				font = "14",
			},
			wezterm = {
				enabled = false,
				font = "+4",
			},
		},
		on_open = function()
			vim.api.nvim_create_autocmd(
				{ "FocusLost", "VimSuspend", "VimLeave" },
				{
					group = zen_group,
					callback = function()
						if os.getenv("TMUX") then
							os.execute("tmux set status on")
						end
					end,
				}
			)
			vim.api.nvim_create_autocmd({ "FocusGained", "VimResume" }, {
				group = zen_group,
				callback = function()
					if os.getenv("TMUX") then
						os.execute("tmux set status off")
					end
				end,
			})
		end,
		on_close = function()
			vim.api.nvim_clear_autocmds({ group = zen_group })
			if vim.bo.filetype ~= "netrw" then
				vim.wo.number = number
				vim.wo.rnu = rnu
				vim.opt.colorcolumn = colorcolumn
			end
		end,
	},
}
