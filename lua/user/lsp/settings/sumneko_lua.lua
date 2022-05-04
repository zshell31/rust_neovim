local sumneko_opts = {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
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

    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)

    lspconfig.setup(opts)
  end
}
