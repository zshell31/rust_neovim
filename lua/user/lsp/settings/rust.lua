local rust_opts = {
  settings = {
		["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy"
      }
		},
  }
}

local tools = {
  autoSetHints = true,
  hover_with_actions = true,
  inlay_hints = {
    only_current_line = false,
    show_parameter_hints = true,
    parameter_hints_prefix = "<- ",
    other_hints_prefix = "=> "
  },
  on_initialized = function()
    vim.cmd([[
      augroup RustToolsOnInitialized
        autocmd CursorHold                          *.rs silent! lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved,InsertEnter            *.rs silent! lua vim.lsp.buf.clear_references()
        autocmd BufEnter,CursorHold,InsertLeave   *.rs silent! lua vim.lsp.codelens.refresh()
        autocmd BufWritePre                         *.rs silent! lua vim.lsp.buf.formatting_sync()
      augroup end
    ]])
  end
}

return {
  install = true,
  setup = function(_, handlers, capabilities)
    -- Initialize the LSP via rust-tools instead
    local rust_status_ok, rust_tools = pcall(require, "rust-tools")
    if not rust_status_ok then
      vim.notify("Cannot load rust-tools")
      return
    end

    local opts = {
      on_attach = handlers.make_on_attach(false, false),
      capabilities = capabilities
    }

    opts = vim.tbl_deep_extend("force", rust_opts, opts)

    rust_tools.setup {
      -- The "server" property provided in rust-tools setup function are the
      -- settings rust-tools will provide to lspconfig during init.
      -- We merge the necessary settings from nvim-lsp-installer (server:get_default_options())
      -- with the user's own settings (opts).
      server = opts,
      tools = tools
    }
  end
}
