local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  vim.notify("Cannot load nvim lsp installer")
  return
end

local servers = {
  "sumneko_lua",
  "rust_analyzer",
  "pyright",
  "clangd"
}

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    -- TODO: show progress in statusline
    print("Installing " .. name)
    server:install()
  end
end

lsp_installer.on_server_ready(function(server)
  local handlers = require("user.lsp.handlers")
  local capabilities = handlers.capabilities

  if server.name == "rust_analyzer" then
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


    local rust_opts = require("user.lsp.settings.rust")
    opts = vim.tbl_deep_extend("force", rust_opts, opts)

    rust_tools.setup {
      -- The "server" property provided in rust-tools setup function are the
      -- settings rust-tools will provide to lspconfig during init.
      -- We merge the necessary settings from nvim-lsp-installer (server:get_default_options())
      -- with the user's own settings (opts).
      server = vim.tbl_deep_extend("force", server:get_default_options(), opts),

      tools = {
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
          show_parameter_hints = false,
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
    }
    server:attach_buffers()
    -- Only if standalone support is needed
    require("rust-tools").start_standalone_if_required()

  else
    local opts = {
      on_attach = handlers.make_on_attach(true),
      capabilities = capabilities,
    }

    if server.name == "sumneko_lua" then
      local sumneko_opts = require("user.lsp.settings.sumneko_lua")
      opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    if server.name == "pyright" then
      local pyright_opts = require("user.lsp.settings.pyright")
      opts = vim.tbl_deep_extend("force", pyright_opts, opts)
    end

    server:setup(opts)
  end

end)
