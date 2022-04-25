local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  vim.notify("Cannot load lualine")
  return
end

lualine.setup {
  options = {
    theme = "auto",
    globalstatus = true
  },
  sections = {
    lualine_c = { "lsp_progress" }
  }
}
