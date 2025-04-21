" ------------------------ General settings --------------------------------

" Global clipboard
set clipboard+=unnamedplus

" <leader> is spacebar
let mapleader = " "

" Extended timeout for mapped sequences. (Eg. <leader>xyz)
set timeoutlen=1500

" Swp files are in the same directory as the original files. (As in vim)
set directory=.

" Set colorscheme automatically
autocmd VimEnter * colorscheme tokyonight-moon

" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

" ------------------------ Key bindings --------------------------------

" Reload the neovim init.vim file
nnoremap <leader>re :source $MYVIMRC <CR>

" Escape terminal mode with Esc
:tnoremap <Esc> <C-\><C-n>

" Create and close tabs with leader tn & tc
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>

" Switch buffers & force close buffers
nnoremap <leader>c :bdelete!<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" Nerd tree hotkeys
" nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

if exists("g:neovide")
  " Use Ctrl+Shift+V to paste system clipboard into the command-line
  cnoremap <C-S-v> <C-R>+
endif


" ------------------------ Plugins --------------------------------

" Vim-Plug https://github.com/junegunn/vim-plug
call plug#begin()

" Syntax checker https://github.com/dense-analysis/ale
Plug 'dense-analysis/ale'

" Markdown preview https://github.com/iamcco/markdown-preview.nvim 
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" File explorer https://github.com/preservim/nerdtree
Plug 'preservim/nerdtree'

" Nice colors I guess
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

" Dependencies for nvim-cmp, autocomplete plugin https://github.com/hrsh7th/nvim-cmp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" Sniped engine for nvim-cmp - luasnip
Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'} 
Plug 'saadparwaiz1/cmp_luasnip'

call plug#end()

" ------------------------ Luasnip Keymaps (Vimscript) --------------------------------

imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<CR>
snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<CR>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<CR>

imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'

" ------------------------ Lua Config Block for nvim-cmp --------------------------------

lua << EOF
local cmp = require'cmp'
local luasnip = require'luasnip'

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
 }, 
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),

    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  })
})
EOF


" ------------------------ LSP for programming --------------------------------
lua << EOF
  require'lspconfig'.clangd.setup{}
  require'lspconfig'.pyright.setup{}
EOF

" Disable all LSP diagnostics

lua vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
