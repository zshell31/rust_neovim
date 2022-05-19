local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
  vim.notify("Cannot load nvim-autopairs")
  return
end

local Rule = require('nvim-autopairs.rule')
local cond = require("nvim-autopairs.conds")

npairs.setup {
  check_ts = true,
  ts_config = {
    lua = { "string", "source" },
  },
  disable_filetype = { "TelescopePrompt" },
  fast_wrap = {
    map = "<M-e>",
    -- chars = { "{", "[", "(", '"', "'", "<", " " },
    chars = { "{", "[", "(", '"', "'", "<" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
    offset = 0,
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    highlight = "PmenuSel",
    highlight_grey = "LineNr"
  },
}

npairs.add_rule(
  Rule("<", ">")
    :with_pair(cond.not_before_text("<"))
)

npairs.add_rule(
  Rule("", ">")
    :use_key(">")
    :with_pair(cond.none())
    :with_move(function(opts) return opts.char == ">" end)
)

npairs.add_rule(
  Rule("<", "<del>")
    :with_pair(function(opts)
      local prev_char = nil
      if opts.col > 1 then
        local pos = opts.col - 1
        prev_char = opts.line:sub(pos, pos)
      end
      print(prev_char)
      return prev_char ~= nil and prev_char == "<" and opts.next_char == ">"
    end)
)

npairs.add_rules {
  Rule(' ', ' ')
    :with_pair(function (opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({ '()', '[]', '{}' }, pair)
    end),
  Rule('( ', ' )')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%)') ~= nil
      end)
      :use_key(')'),
  Rule('{ ', ' }')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%}') ~= nil
      end)
      :use_key('}'),
  Rule('[ ', ' ]')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%]') ~= nil
      end)
      :use_key(']')
}

local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  vim.notify("Cannot load cmp")
  return
end

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
