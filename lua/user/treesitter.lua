local status_ok, treesitter_cfg = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  vim.notify("Cannot load nvim-treesitter configs")
  return
end

treesitter_cfg.setup {
  ensure_installed = "all",
  sync_install = false,
  ignore_install = { "" },
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true,
    disable = { "" },
    additional_vim_regex_highlighting = true
  },
  indent = {
    enable = true,
    disable = {
      "yaml",
    },
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  endwise = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = false,
  }
}
