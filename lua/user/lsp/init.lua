local M = {}

M.setup = function()
  local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
  if not status_ok then
    vim.notify("Cannot load nvim-lsp-installer")
    return
  end

  local settings = require("user.lsp.settings")

  local exclude = {}
  local to_install = {}
  for server, conf in pairs(settings) do
    if not conf.install then
      table.insert(exclude, server)
    else
      table.insert(to_install, server)
    end
  end

  lsp_installer.setup {
    ensure_installed = to_install,
    automatic_installation = {
      exclude = exclude,
    },
    ui = {
      icons = {
        server_installed = "✓",
        server_pending = "➜",
        server_uninstalled = "✗",
      }
    },
  }

  vim.lsp.set_log_level("debug")
  require("user.lsp.lspconfig").setup()
end

return M
