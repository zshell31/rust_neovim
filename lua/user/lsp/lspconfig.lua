local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  vim.notify("Cannot load lspconfig")
  return
end

local M = {}

local settings = require("user.lsp.settings")
local handlers = require("user.lsp.handlers")
local capabilities = handlers.capabilities

M.setup = function()
  -- Setup lsp servers
  for server, conf in pairs(settings) do
    conf.setup(lspconfig[server], handlers, capabilities)
  end

  -- Setup diagnostics
  local signs = {
    -- Taken from trouble
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = true,
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  -- Setup lsp handlers
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    focusable = false,
    border = "rounded",
  })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    focusable = false,
    border = "rounded",
  })
end

return M
