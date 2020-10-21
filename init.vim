" Automaticall install Vim Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" On-demand loading
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'HerringtonDarkholme/yats.vim' "For Typescript Highlight
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'luochen1990/rainbow'
Plug 'brooth/far.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'APZelos/blamer.nvim'
Plug 'morhetz/gruvbox'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }

" Initialize plugin system
call plug#end()

" CtrlP Config
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }

let g:rainbow_active = 1
let g:blamer_enabled = 1

" Git Gutter Config
set updatetime=100

set number
let mapleader=" "
nnoremap <SPACE> <Nop>

map <Leader>n :NERDTreeToggle<CR>
map <Leader>p :Leaderf file<CR>

let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1

" shortcut for far.vim find
nnoremap <silent> <Leader>f :Farf<cr>
vnoremap <silent> <Leader>f :Farf<cr>

" shortcut for far.vim replace
nnoremap <silent> <Leader>f :Farr<cr>
vnoremap <silent> <Leader>f :Farr<cr>

map <Leader>d :vert Gdiff<CR>

autocmd vimenter * colorscheme gruvbox
set bg=light
set autowrite
set smartcase
