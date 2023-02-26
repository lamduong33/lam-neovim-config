vim.cmd [[packadd packer.nvim]]
vim.g.mapleader = ' '
local use = require('packer').use

return require('packer').startup(function()
    use 'wbthomason/packer.nvim' -- Package manager
    use "williamboman/nvim-lsp-installer"
    use 'neovim/nvim-lspconfig' -- Collection of configurations for the built-in LSP client
    use 'nvim-lua/lsp-status.nvim' -- status for lsp on the lualine
    use 'kyazdani42/nvim-web-devicons'

    -- autocompletion
    use 'hrsh7th/cmp-nvim-lsp'
    -- use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    -- snippets
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    use 'liuchengxu/vim-clap'
    use({
        'CosmicNvim/cosmic-ui',
        requires = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
        config = function()
        require('cosmic-ui').setup()
    end,
    })

    -- Visual
    use {
      "lukas-reineke/indent-blankline.nvim", -- show the indentation level
      config = function()
      end
    }

    -- use 'folke/tokyonight.nvim'
    use 'shaunsingh/nord.nvim'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- Lua line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- Treesitter - better syntax highlighting
    use {
    'kyazdani42/nvim-tree.lua',
        requires = {
          'kyazdani42/nvim-web-devicons', -- optional, for file icon
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    -- Others
    use 'tpope/vim-fugitive' -- git intergation
    use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
    use 'lervag/vimtex' -- latex
    use {
        "folke/which-key.nvim",
        config = function()
        require("which-key").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
    end
    }
    use 'norcalli/nvim-colorizer.lua' -- colorizer
    -- Tabs
    use {
        'romgrk/barbar.nvim',
        requires = {'kyazdani42/nvim-web-devicons'}
    }
    use {
        'lewis6991/gitsigns.nvim',
        -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
    }
    -- Formatting
    use 'sbdchd/neoformat'
    -- Telescope - fuzzy finding
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use { "nvim-telescope/telescope-file-browser.nvim" }
    -- Zen mode
    use {
      "folke/zen-mode.nvim",
      config = function()
        require("zen-mode").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }

    -- Complete web brackets and such
    use "windwp/nvim-ts-autotag"
    -- Auto complete pairs such as brackets, parantheses, and such.
    use "keitokuch/vterm"

    use "vimwiki/vimwiki"

    use "ianding1/leetcode.vim"

end)
