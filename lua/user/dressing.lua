local status_ok, dressing = pcall(require, "dressing")
if not status_ok then
  vim.notify("Cannot load dressing")
  return
end

dressing.setup {
  select = {
    enabled = true,
    backend = { "telescope" },
    telescope = require("telescope.themes").get_dropdown {
      previewer = false,
      height = 20,
      width = 120,
    }
  }
}
