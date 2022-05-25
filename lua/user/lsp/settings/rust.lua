local lspconfig_utils = require("lspconfig.util")
local Path = require("plenary.path")

local current_dir = nil

local function get_cwd_root()
  local cwd = vim.fn.getcwd()
  local cargo_crate_dir = lspconfig_utils.root_pattern("Cargo.toml")(cwd)
  return cargo_crate_dir
    or lspconfig_utils.find_git_ancestor(cwd)
end

local function get_root_dir(filename)
  if current_dir == nil then
    current_dir = get_cwd_root()
  end
  local fname = filename or vim.api.nvim_buf_get_name(0)
  if current_dir ~= nil then
    if fname:find(current_dir) == nil then
      return
    end
  end
  local cargo_crate_dir = lspconfig_utils.root_pattern("Cargo.toml")(fname)
  local cmd = { "cargo", "metadata", "--no-deps", "--format-version", "1" }
  if cargo_crate_dir ~= nil then
    cmd[#cmd + 1] = "--manifest-path"
    cmd[#cmd + 1] = lspconfig_utils.path.join(cargo_crate_dir, "Cargo.toml")
  end
  local cargo_metadata = ""
  local cm = vim.fn.jobstart(cmd, {
    on_stdout = function(_, d, _)
      cargo_metadata = table.concat(d, "\n")
    end,
    stdout_buffered = true,
  })
  if cm > 0 then
    cm = vim.fn.jobwait({ cm })[1]
  else
    cm = -1
  end
  local cargo_workspace_dir = nil
  if cm == 0 then
    cargo_workspace_dir = vim.fn.json_decode(cargo_metadata)["workspace_root"]
  end
  return cargo_workspace_dir
    or cargo_crate_dir
    or lspconfig_utils.root_pattern("rust-project.json")(fname)
    or lspconfig_utils.find_git_ancestor(fname)
end

local rust_opts = {
  root_dir = get_root_dir,
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

    opts = vim.tbl_deep_extend("force", opts, rust_opts)

    local settings = Path:new("rust_settings.json")
    if settings:exists() then
      local local_opts = vim.json.decode(settings:read())
      opts.settings = local_opts
    end

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
