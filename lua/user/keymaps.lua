local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-s>", ":w<CR>", opts)

keymap("n", "<S-L>", ":bnext<CR>", opts)
keymap("n", "<S-H>", ":bprevious<CR>", opts)
keymap("n", "<C-q>", ":bd<CR>", opts)
keymap("n", "<C-b>", ":NvimTreeToggle<CR>", opts)

keymap("n", "<leader>d", ":TroubleToggle<CR>", opts)
keymap("n", "<leader>f", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>g", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>s", ":Telescope grep_string<CR>", opts)

keymap("n", "<leader>t", "lua show_tabs()<CR>", opts)
function show_tabs()
  local tele_tabby_opts = require "telescope.themes".get_dropdown {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
    height = 30,
    width = 120,
  }
  require "telescope".extensions.tele_tabby.list(tele_tabby_opts)
end

keymap("i", "jk", "<ESC>", opts)
keymap("i", "<C-s>", "<ESC>:w<CR>i", opts)

keymap("v", "<", "<gv", opts)
keymap("v", "<S-Tab>", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "<Tab>", ">gv", opts)

keymap("v", "p", '"_dP', opts)

keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
