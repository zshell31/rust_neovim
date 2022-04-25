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

keymap("n", "<S-K>", ":bnext<CR>", opts)
keymap("n", "<S-J>", ":bprevious<CR>", opts)
keymap("n", "<C-w>", ":bd<CR>", opts)
keymap("n", "<C-b>", ":NvimTreeToggle<CR>", opts)

keymap("n", "<leader>t", ":TroubleToggle<CR>", opts)
keymap("n", "<leader>f", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>g", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>s", ":Telescope grep_string<CR>", opts)

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
