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
Plug 'airblade/vim-gitgutter'
Plug 'HerringtonDarkholme/yats.vim' "For Typescript Highlight
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'chrisbra/Colorizer'
Plug 'morhetz/gruvbox'

" Initialize plugin system
call plug#end()

" COC Config
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gh :call <SID>show_documentation()<CR>
nmap <silent> <Leader>, :CocAction<CR>
nmap <Leader>r <Plug>(coc-rename)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

try
    nmap <Leader>e :call CocAction('diagnosticNext')<cr>
    nmap <Leader>E :call CocAction('diagnosticPrevious')<cr>
endtry

" Git Gutter Config
set updatetime=100

set number
let mapleader=" "
nnoremap <SPACE> <Nop>

nmap <Leader>n :CocCommand explorer<CR>
map <Leader>p :GFiles<CR>
map <Leader>g :Git<CR>

let g:airline_powerline_fonts = 1

" shortcut for Silver Search
nnoremap <silent> <Leader>f :Ag<cr>
vnoremap <silent> <Leader>f :Ag<cr>

map <Leader>d :vert Gdiff<CR>

set autowrite
set smartcase
set ignorecase
set tabstop=2
set shiftwidth=2
set shell=fish
set expandtab
autocmd VimEnter * ColorHighlight
autocmd vimenter * colorscheme gruvbox
set background=light
set foldmethod=syntax
set foldlevelstart=1
let javaScript_fold=1
