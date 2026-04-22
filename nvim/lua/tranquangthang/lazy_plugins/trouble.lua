return {
	"folke/trouble.nvim",
	cmd = "Trouble",
	keys = function()
		local trouble = require("trouble")
		return {
			{
				"<leader>xx",
				function()
					trouble.toggle("diagnostics")
				end,
			},
			{
				"<leader>xX",
				function()
					trouble.toggle({
						mode = "diagnostics",
						filter = {
							buf = 0,
						},
					})
				end,
			},
			{
				"<leader>cs",
				function()
					trouble.toggle({ mode = "symbols", focus = false })
				end,
			},
			{
				"<leader>cl",
				function()
					trouble.toggle({
						mode = "lsp",
						focus = false,
						win = {
							position = "right",
						},
					})
				end,
			},
			{
				"<leader>xL",
				function()
					trouble.toggle({ mode = "loclist" })
				end,
			},
			{
				"<leader>xQ",
				function()
					trouble.toggle({ mode = "qflist" })
				end,
			},
		}
	end,
	opts = {
		debug = false,
		auto_close = false,
		auto_open = false,
		auto_preview = true,
		auto_refresh = true,
		auto_jump = false,
		focus = false,
		restore = true,
		follow = true,
		indent_guides = true,
		max_items = 200,
		multiline = true,
		pinned = false,
		warn_no_results = true,
		open_no_results = false,
		win = {},
		preview = {
			type = "main",
			scratch = true,
		},
		throttle = {
			refresh = 20,
			update = 10,
			render = 10,
			follow = 100,
			preview = { ms = 100, debounce = true },
		},
		keys = {
			["?"] = "help",
			r = "refresh",
			R = "toggle_refresh",
			q = "close",
			o = "jump_close",
			["<esc>"] = "cancel",
			["<cr>"] = "jump",
			["<2-leftmouse>"] = "jump",
			["<c-s>"] = "jump_split",
			["<c-v>"] = "jump_vsplit",
			["}"] = "next",
			["]]"] = "next",
			["{"] = "prev",
			["[["] = "prev",
			i = "inspect",
			p = "preview",
			P = "toggle_preview",
			zo = "fold_open",
			zO = "fold_open_recursive",
			zc = "fold_close",
			zC = "fold_close_recursive",
			za = "fold_toggle",
			zA = "fold_toggle_recursive",
			zm = "fold_more",
			zM = "fold_close_all",
			zr = "fold_reduce",
			zR = "fold_open_all",
			zx = "fold_update",
			zX = "fold_update_all",
			zn = "fold_disable",
			zN = "fold_enable",
			zi = "fold_toggle_enable",
			gb = {
				action = function(view)
					view:filter({ buf = 0 }, { toggle = true })
				end,
				desc = "Toggle Current Buffer Filter",
			},
			s = {
				action = function(view)
					local f = view:get_filter("severity")
					local severity = ((f and f.filter.severity or 0) + 1) % 5
					view:filter({ severity = severity }, {
						id = "severity",
						template = "{hl:Title}Filter:{hl} {severity}",
						del = severity == 0,
					})
				end,
				desc = "Toggle Severity Filter",
			},
		},
		modes = {
			symbols = {
				desc = "document symbols",
				mode = "lsp_document_symbols",
				focus = false,
				win = { position = "right" },
				filter = {
					["not"] = { ft = "lua", kind = "Package" },
					any = {
						ft = { "help", "markdown" },
						kind = {
							"Class",
							"Constructor",
							"Enum",
							"Field",
							"Function",
							"Interface",
							"Method",
							"Module",
							"Namespace",
							"Package",
							"Property",
							"Struct",
							"Trait",
						},
					},
				},
			},
		},
		icons = {
			indent = {
				top = "│ ",
				middle = "├╴",
				last = "╰╴",
				fold_open = " ",
				fold_closed = " ",
				ws = "  ",
			},
			folder_closed = " ",
			folder_open = " ",
			kinds = {
				Array = " ",
				Boolean = "󰨙 ",
				Class = " ",
				Constant = "󰏿 ",
				Constructor = " ",
				Enum = " ",
				EnumMember = " ",
				Event = " ",
				Field = " ",
				File = " ",
				Function = "󰊕 ",
				Interface = " ",
				Key = " ",
				Method = "󰊕 ",
				Module = " ",
				Namespace = "󰦮 ",
				Null = " ",
				Number = "󰎠 ",
				Object = " ",
				Operator = " ",
				Package = " ",
				Property = " ",
				String = " ",
				Struct = "󰆼 ",
				TypeParameter = " ",
				Variable = "󰀫 ",
			},
		},
	},
}
