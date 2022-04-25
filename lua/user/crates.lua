local status_ok, crates = pcall(require, "crates")
if not status_ok then
  vim.notify("Cannot load crates")
  return
end

crates.setup {}
