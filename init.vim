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
nnoremap <S-Tab> :previous<CR>

" Nerd tree hotkeys
nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
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

call plug#end()

