local M = {}

table.insert(M, {
	"hrsh7th/nvim-cmp",

	dependencies = {
		"L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
		"windwp/nvim-autopairs",
		"onsails/lspkind.nvim",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
	},

	opts = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		return {
			preselect = "item",
			formatting = {
				fields = { "abbr", "kind", "menu" },
				expandable_indicator = true,
				format = require("lspkind").cmp_format({}),
			},

			mapping = cmp.mapping.preset.insert({
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<Tab>"] = cmp.mapping.confirm({ select = false }),

				["<C-n>"] = cmp.mapping(function()
					if cmp.visible() then
						cmp.abort()
					else
						cmp.complete()
					end
				end),

				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-k>"] = cmp.mapping.select_prev_item(),

				["<C-w>"] = cmp.mapping(function()
					luasnip.jump(1)
				end, { "i", "s" }),
				["<C-b>"] = cmp.mapping(function()
					luasnip.jump(-1)
				end, { "i", "s" }),

				["<C-u>"] = cmp.mapping.scroll_docs(-5),
				["<C-d>"] = cmp.mapping.scroll_docs(5),
			}),

			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},

			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},

			completion = {
				completeopt = "menu,menuone,noinsert",
			},

			sources = cmp.config.sources({
				{ name = "path" },
				{ name = "nvim_lsp" },
				{ name = "lazydev" },
				{ name = "luasnip" },
			}, {
				{ name = "buffer" },
			}),
		}
	end,

	config = function(_, opts)
		local cmp = require("cmp")
		local capabilities = vim.tbl_extend(
			"force",
			vim.lsp.protocol.make_client_capabilities(),
			require("cmp_nvim_lsp").default_capabilities()
		)

		require("luasnip.loaders.from_vscode").lazy_load()

		vim.opt.completeopt = { "menu", "menuone", "noselect" }

		cmp.event:on(
			"confirm_done",
			require("nvim-autopairs.completion.cmp").on_confirm_done
		)

		cmp.setup(opts)

		cmp.setup.filetype("sql", {
			sources = {
				{ name = "vim-dadbob-completion" },
				{ name = "buffer" },
			},
		})

		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
				{ name = "cmdline" },
			}),
		})

		for server, _ in pairs(vim.lsp._enabled_configs) do
			vim.lsp.config(server, { capabilities = capabilities })
		end
	end,
})

return M
