local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  vim.notify("Cannot load lspconfig")
  return
end

require("user.lsp.lsp-installer")
require("user.lsp.lspconfig")
require("user.lsp.handlers").setup()

