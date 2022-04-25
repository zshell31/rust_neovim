local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  vim.notify("Cannot load comment")
  return
end

-- Only for languages like jsx/vue etc
-- comment.setup {
--   pre_hook = function (ctx)
--     local U = require("Comment.utils")
--     local tsc = require("ts_context_commentstring.utils")
--
--     local location = nil
--     if ctx.ctype == U.ctype.block then
--       location = tsc.get_cursor_location()
--     elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
--       location = tsc.get_visual_start_location()
--     end
--
--     local type = ctx.ctype == U.ctype.line and '__default' or '__multiline'
--
--     return require("ts_context_commentstring.internal").calculate_commentstring({
--       key = type,
--       location = location
--     })
--
--   end
-- }

comment.setup()
