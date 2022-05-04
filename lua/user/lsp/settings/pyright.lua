local pyright_opts = {
	settings = {
		pyright = {
      analysis = {
        typeCheckingMode = "on"
      }
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

    opts = vim.tbl_deep_extend("force", pyright_opts, opts)

    lspconfig.setup(opts)
  end
}
