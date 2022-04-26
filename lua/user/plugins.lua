local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  vim.cmd [[packadd packer.nvim]]
end

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("Cannot load packer")
  return
end

packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(function(use)
  use "wbthomason/packer.nvim"

  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"

  use "Mofiqul/dracula.nvim"

  use "kyazdani42/nvim-web-devicons"

  use "onsails/lspkind.nvim"

  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "saadparwaiz1/cmp_luasnip"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"

  use "L3MON4D3/LuaSnip"
  use "rafamadriz/friendly-snippets"

  use "neovim/nvim-lspconfig"
  use "williamboman/nvim-lsp-installer"
  use "simrat39/rust-tools.nvim"

  use "folke/trouble.nvim"

  use "kyazdani42/nvim-tree.lua"
  use "goolord/alpha-nvim"
  use "moll/vim-bbye"

  use "nvim-telescope/telescope.nvim"
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use "stevearc/dressing.nvim"

  use "nvim-lualine/lualine.nvim"
  use "arkav/lualine-lsp-progress"
  use "akinsho/bufferline.nvim"

  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "RRethy/nvim-treesitter-endwise"
  use "p00f/nvim-ts-rainbow"
  use "nvim-treesitter/playground"
  use "windwp/nvim-autopairs"

  use "numToStr/Comment.nvim"
  use "JoosepAlviste/nvim-ts-context-commentstring"

  use "lewis6991/gitsigns.nvim"

  use "saecki/crates.nvim"

  use "rmagatti/auto-session"

  -- Markdown
  use {
    "lukas-reineke/headlines.nvim",
    config = function ()
      local hstatus_ok, headlines = pcall(require, "headlines")
      if not hstatus_ok then
        vim.notify("Cannot load headlines")
        return
      end
      headlines.setup()
    end
  }

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
