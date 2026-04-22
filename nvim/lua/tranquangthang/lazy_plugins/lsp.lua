local M = {}

local lsp_group =
	vim.api.nvim_create_augroup("tranquangthang/lsp", { clear = true })

local enable_servers = {
	"ccls",
	"html",
	"cssls",
	"emmet_language_server",
	"tailwindcss",
	"ts_ls",
	"gdscript",
	"gopls",
	"dockerls",
	"docker_compose_language_service",
	"bashls",
	"templ",
	"rust_analyzer",
	"taplo",
	"zls",
	"lua_ls",
	"roslyn_ls",
	"nil_ls",
	"ruff",
	"pyright",
	"jsonls",
	"yamlls",
}

local keys_normal = {
	["gd"] = function()
		if not pcall(require("telescope.builtin").lsp_definitions) then
			vim.lsp.buf.definition()
		end
	end,
	["gr"] = function()
		if not pcall(require("telescope.builtin").lsp_references) then
			vim.lsp.buf.references()
		end
	end,
	["<leader>ws"] = function()
		if not pcall(require("telescope.builtin").lsp_workspace_symbols) then
			vim.lsp.buf.workspace_symbol()
		end
	end,
	["<leader>ds"] = function()
		if not pcall(require("telescope.builtin").lsp_document_symbols) then
			vim.lsp.buf.document_symbol()
		end
	end,
	["<leader>ca"] = function()
		vim.lsp.buf.code_action()
	end,
	["<leader>rn"] = function()
		vim.lsp.buf.rename()
	end,
	["<C-s>"] = function()
		vim.lsp.buf.signature_help({ border = "rounded" })
	end,
	["K"] = function()
		vim.lsp.buf.hover({ border = "rounded" })
	end,
	["<leader>vd"] = function()
		vim.diagnostic.open_float({ border = "rounded" })
	end,
	["]d"] = function()
		vim.diagnostic.jump({ count = 1, float = true })
	end,
	["[d"] = function()
		vim.diagnostic.jump({ count = -1, float = true })
	end,
	["<leader>f"] = function(bufnr)
		local format_opts = {
			lsp_format = "fallback",
			bufnr = bufnr,
			async = true,
			stop_after_first = true,
		}

		if not pcall(require("conform").format, format_opts) then
			vim.lsp.buf.format(format_opts)
		end
	end,
}

local keys_insert = { ["<C-s>"] = keys_normal["<C-s>"] }

table.insert(M, {
	"neovim/nvim-lspconfig",
	config = function()
		vim.diagnostic.config({
			virtual_text = true,
			severity_sort = true,
			float = {
				style = "minimal",
				border = "rounded",
				source = true,
				header = "",
				prefix = "",
			},
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "✘",
					[vim.diagnostic.severity.WARN] = "▲",
					[vim.diagnostic.severity.HINT] = "⚑",
					[vim.diagnostic.severity.INFO] = "»",
				},
			},
		})

		vim.lsp.enable(enable_servers)

		vim.api.nvim_create_autocmd("LspAttach", {
			group = lsp_group,
			callback = function(e)
				for key, exec in pairs(keys_normal) do
					vim.keymap.set("n", key, function()
						exec(e.buf)
					end, { buffer = e.buf })
				end

				for key, exec in pairs(keys_insert) do
					vim.keymap.set("i", key, function()
						exec()
					end, { buffer = e.buf })
				end
			end,
		})
	end,
})

table.insert(M, {
	"mason-org/mason.nvim",
	opts = {
		ui = {
			border = "rounded",
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	},
	config = function(_, opts)
		require("mason").setup(opts)

		local registry = require("mason-registry")

		local lsp_servers = { "lua-language-server" }
		local formatters = { "stylua" }

		local pkgs = vim.deepcopy(lsp_servers)
		vim.list_extend(pkgs, formatters)

		for _, pkg_name in ipairs(pkgs) do
			local ok, pkg = pcall(registry.get_package, pkg_name)
			if ok and not pkg:is_installed() then
				pkg:install()
			end
		end
	end,
})

table.insert(M, {
	"folke/lazydev.nvim",
	ft = "lua",
	opts = {
		debug = false,
		runtime = vim.env.VIMRUNTIME,
		library = { path = "${3rd}/luv/library", words = { "vim%.uv" } },
		integrations = { lspconfig = true, cmp = true, coq = false },
		enabled = function(root_dir)
			return (vim.g.lazydev_enabled == nil or vim.g.lazydev_enabled)
				and not vim.uv.fs_stat(root_dir .. "/.luarc.json")
		end,
	},
})

table.insert(M, {
	"b0o/SchemaStore.nvim",
	config = function()
		vim.lsp.config("jsonls", {
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		})
		vim.lsp.config("yamlls", {
			yaml = {
				schemas = require("schemastore").yaml.schemas(),
				schemaStore = {
					enable = false,
					url = "",
				},
			},
		})
	end,
})

return M
