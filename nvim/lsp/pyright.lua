local lsp = require("lspconfig")

lsp.pyright.setup{
  settings = {
    pyright = { disableOrganizeImports = true },
    python = {
      analysis = {
        ignore = {},
        diagnosticMode = "workspace",
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
}
-- Gợi ý: đảm bảo hiện lỗi rõ
vim.diagnostic.config({ virtual_text=true, signs=true, underline=true, update_in_insert=false })
vim.o.signcolumn = "yes"

