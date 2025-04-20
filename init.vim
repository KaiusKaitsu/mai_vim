" Global clipboard
set clipboard+=unnamedplus

" <leader> is spacebar
let mapleader = " "

" Split screen with leader + sv / sh 
nnoremap <silent> <leader>sv :vsplit<CR>
nnoremap <silent> <leader>sh :split<CR>

" Reload the neovim init.vim file
nnoremap <leader>re :source $MYVIMRC

" Escape terminal mode with Esc
:tnoremap <Esc> <C-\><C-n>

" Extended timeout for mapped sequences. (Eg. <leader>xyz)
set timeoutlen=1500

" Swp files are in the same directory as the original files. (As in vim)
set directory=.

" Switch tabs with tab and shift tab and create and close with leader tn & tc
nnoremap <Tab> :tabnext<CR>
nnoremap <S-Tab> :tabprevious<CR>
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>

" Switch buffers & force close buffers
nnoremap <leader>b :bnext<CR>
nnoremap <leader>c :bdelete!<CR>

" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

" Set colorscheme automatically
autocmd VimEnter * colorscheme tokyonight-moon

" Nerd tree hotkeys
nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

if exists("g:neovide")
  " Use Ctrl+Shift+V to paste system clipboard into the command-line
  cnoremap <C-S-v> <C-R>+
endif

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

call plug#end()

