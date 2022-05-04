local rnix_opts = {
	settings = {}
}

return {
  install = false,
  setup = function(lspconfig, handlers, capabilities)
    local opts = {
      on_attach = handlers.make_on_attach(true),
      capabilities = capabilities,
    }

    opts = vim.tbl_deep_extend("force", rnix_opts, opts)

    lspconfig.setup(opts)
  end
}
