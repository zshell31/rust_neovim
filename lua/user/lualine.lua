local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  vim.notify("Cannot load lualine")
  return
end

-- local function get_diagnostics()
--   local diagnostics = vim.diagnostic.get()
--   local count = { 0, 0, 0, 0 }
--   for _, diagnostic in ipairs(diagnostics) do
--     count[diagnostic.severity] = count[diagnostic.severity] + 1
--   end
-- end

lualine.setup {
  options = {
    theme = "auto",
    globalstatus = true
  },
  sections = {
    lualine_b = {
      "branch",
      "diff",
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        always_visible = true,
      },
    },
    lualine_c = { 
      {
        "lsp_progress",
        fmt = function (str)
          if str:len() > 80 then
            return str:sub(1, 80) .. ".."
          else
            return str
          end
        end,
        spinner_symbols = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' },
      },
      {
        "filename",
        file_status = false,
        path = 1,
        shorting_target = 40,
      }
    }
  }
}
