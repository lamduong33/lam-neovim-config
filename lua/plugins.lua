vim.cmd [[packadd packer.nvim]]
vim.g.mapleader = ' '
local use = require('packer').use

return require('packer').startup(function()
    use 'wbthomason/packer.nvim' -- Package manager
    use "williamboman/nvim-lsp-installer"
    use 'neovim/nvim-lspconfig' -- Collection of configurations for the built-in LSP client

    -- autocompletion
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    -- snippets
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    use 'andweeb/presence.nvim'
    use 'liuchengxu/vim-clap'
    use({
        'CosmicNvim/cosmic-ui',
        requires = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
        config = function()
        require('cosmic-ui').setup()
    end,
    })

    -- Visual
    use 'glepnir/dashboard-nvim'
    use 'folke/tokyonight.nvim'
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

    -- Treesitter
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

end)
