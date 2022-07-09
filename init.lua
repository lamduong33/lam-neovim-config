--------------------------------Vim settings from vimrc -----------------------
vim.cmd([[
packadd packer.nvim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
syntax enable
" vimrc
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
set termguicolors " this variable must be enabled for colors to be applied properly
]])


-------------------------NVIM LUA CONFIG -----------------------------------

-- Leader key
vim.g.mapleader = ' '
-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Start using plugins file in the lua folder
require('plugins')

-- For popups and how long it takes to show them
vim.opt.timeoutlen = 300
vim.opt.updatetime = 100

----------------------- SUGGESTED LSP CONFIG -------------------------------------
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
map('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
map('n', '<leader>qd', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
map('n', '<leader>qq','<cmd>quitall<CR>',opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer', 'tsserver', 'clangd'}
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require("nvim-lsp-installer").setup{}
require'lspconfig'.pyright.setup{
  capabilities = capabilities
}
require'lspconfig'.texlab.setup{
  capabilities = capabilities
}
require'lspconfig'.clangd.setup{
  capabilities = capabilities
}
-- require'lspconfig'.eslint.setup{}
require'lspconfig'.tsserver.setup{
    cmd = { "typescript-language-server", "--stdio"},
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
}

-- TreeSitter config taken from their github page
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "lua", "rust", "javascript", "html" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  -- ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    -- additional_vim_regex_highlighting = false,
  },
}

----------------------------- AUTO-COMPLETION  --------------------------------

-- Luasnip setup
local luasnip = require 'luasnip'

-- Setup nvim-cmp.
local cmp = require'cmp'
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
  }, {
    { name = 'buffer' },
  }),
  experimental = {
      ghost_text = true
  }
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it. 
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

----------------------------- Lua-line --------------------------------
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'tokyonight',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
----------------------------- OTHERS --------------------------------

-- Dashboard 
local home = os.getenv('HOME')
local db = require('dashboard')
db.custom_center = {
  {icon = ' ',
  desc = 'Reload Last Session                     ',
  shortcut = 'SPC s l',
  action ='SessionLoad'},
  {icon = ' ',
  desc = 'Recently opened files                   ',
  action =  'DashboardFindHistory',
  shortcut = 'SPC f r'},
  {icon = ' ',
  desc = 'Find  File                              ',
  action = 'Telescope find_files find_command=rg,--hidden,--files',
  shortcut = 'SPC f f'},
  {icon = ' ',
  desc = 'File Browser                            ',
  action =  'Telescope file_browser',
  shortcut = 'SPC .  '},
  {icon = ' ',
  desc = 'Find word                               ',
  action = 'Telescope live_grep',
  shortcut = 'SPC f w'},
  {icon = ' ',
  desc = 'Open NVim dotfiles                      ',
  action = 'Telescope dotfiles path=' .. home ..'/.config/nvim',
  shortcut = 'SPC f p'},
}
map('n', '<leader>sl', '<cmd>SessionLoad<CR>', opts)
map('n', '<leader>fr', '<cmd>DashboardFindHistory<CR>', opts)
map('n', '<leader>ff', '<cmd>Telescope find_files find_command=rg,--hidden,--files<CR>', opts)
map('n', '<leader>.', '<cmd>Telescope file_browser<CR>', opts)
map('n', '<leader>fw', '<cmd>Telescope live_grep<CR>', opts)
map('n', '<leader>fw', '<cmd>Telescope dotfiles path=' .. home ..'/.config/nvim<CR>', opts)

local vim_header = {
"                        .               ",     
"    ##############..... ##############  ", 
"    ##############......##############  ", 
"      ##########..........##########    ", 
"      ##########........##########      ", 
"      ##########.......##########       ", 
"      ##########.....##########..       ", 
"      ##########....##########.....     ", 
"    ..##########..##########.........   ", 
"  ....##########.#########............. ", 
"    ..################JJJ............   ", 
"      ################.............     ", 
"      ##############.JJJ.JJJJJJJJJJ     ", 
"      ############...JJ...JJ..JJ  JJ    ", 
"      ##########....JJ...JJ..JJ  JJ     ", 
"      ########......JJJ..JJJ JJJ JJJ    ", 
"      ######    .........               ",
"                  .....                 ", 
"                    .                   ",
}
db.custom_header=vim_header

-- Telescope file browser
require("telescope").load_extension "file_browser"

-- Neogit: similar to Magit
local neogit = require('neogit')
neogit.setup {}

-- Nvim-Tree setup using defaults: add your own options
require'nvim-tree'.setup {
}

-- Nord theme setup
vim.g.nord_contrast = true
vim.g.nord_borders = false
vim.g.nord_disable_background = true
vim.g.nord_italic = true

-- Tokyonight theme
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_comments = true
vim.g.tokyonight_transparent = true
vim.g.tokyonight_transparent_sidebar = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }

vim.cmd([[colorscheme tokyonight]])
