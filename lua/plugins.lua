vim.cmd [[packadd packer.nvim]]
vim.g.mapleader = ' '
local use = require('packer').use

return require('packer').startup(function()
    use 'wbthomason/packer.nvim' -- Package manager
    use 'neovim/nvim-lspconfig' -- Collection of configurations for the built-in LSP client

    -- autocompletion
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    use 'arcticicestudio/nord-vim'
    use 'andweeb/presence.nvim'

    use 'liuchengxu/vim-clap'
    use({
        'CosmicNvim/cosmic-ui',
        requires = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
        config = function()
        require('cosmic-ui').setup()
    end,
    })
    use 'glepnir/dashboard-nvim'
end)
