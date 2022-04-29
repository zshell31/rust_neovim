local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  vim.notify("Cannot load lspconfig")
  return
end

local handlers = require("user.lsp.handlers")

local opts = {
  on_attach = handlers.make_on_attach(true, true),
  capabilities = handlers.capabilities
}

-- Install hls/ormolu using ghcup
-- hls works fine for ghc 9.0.2
-- for 9.2.2 see https://github.com/haskell/haskell-language-server/issues/2179
local hls_opts = require("user.lsp.settings.hls")
lspconfig.hls.setup(vim.tbl_deep_extend("force", hls_opts, opts))

