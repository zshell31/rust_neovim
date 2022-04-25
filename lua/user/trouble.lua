local status_ok, trouble = pcall(require, "trouble")
if not status_ok then
  vim.notify("Cannot load trouble")
  return
end

trouble.setup {
  auto_close = true,
}
