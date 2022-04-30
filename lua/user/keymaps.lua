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
keymap("n", "<C-q>", ":Bdelete!<CR>", opts)
keymap("n", "<C-b>", ":NvimTreeToggle<CR>", opts)

keymap("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>", opts)
keymap("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>", opts)
keymap("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>", opts)
keymap("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>", opts)
keymap("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>", opts)
keymap("n", "<leader>6", ":BufferLineGoToBuffer 6<CR>", opts)
keymap("n", "<leader>7", ":BufferLineGoToBuffer 7<CR>", opts)
keymap("n", "<leader>8", ":BufferLineGoToBuffer 8<CR>", opts)
keymap("n", "<leader>9", ":BufferLineGoToBuffer 9<CR>", opts)
keymap("n", "<C-g>", ":BufferLinePick<CR>", opts)

keymap("n", "<leader>d", ":TroubleToggle<CR>", opts)
keymap("n", "<leader>f", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>g", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>s", ":Telescope grep_string<CR>", opts)
keymap("n", "<leader>t", ":lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown({ previewer = false, height = 20, width = 120}))<CR>", opts)
keymap("n", "<leader>b", ":Telescope yabs tasks<CR>", opts)

keymap("n", "<leader>q", ":lua require('rest-nvim').run()<CR>", opts)

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
