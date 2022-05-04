-- Install hls/ormolu using ghcup
-- hls works fine for ghc 9.0.2
-- for 9.2.2 see https://github.com/haskell/haskell-language-server/issues/2179
local hls_opts = {
  cmd = {
    "haskell-language-server-wrapper", "--lsp",
  },
	settings = {
	},
}

return {
  install = false,
  setup = function(lspconfig, handlers, capabilities)
    local opts = {
      on_attach = handlers.make_on_attach(true, true),
      capabilities = capabilities
    }

    opts = vim.tbl_deep_extend("force", hls_opts, opts)

    lspconfig.setup(opts)
  end
}
