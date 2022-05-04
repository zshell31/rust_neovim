local clangd_opts = {
	settings = {
		clangd = {
		},
	},
}

return {
  install = true,
  setup = function(lspconfig, handlers, capabilities)
    local opts = {
      on_attach = handlers.make_on_attach(true),
      capabilities = capabilities,
    }

    opts = vim.tbl_deep_extend("force", clangd_opts, opts)

    lspconfig.setup(opts)
  end
}
