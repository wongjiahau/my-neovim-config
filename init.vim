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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'chrisbra/Colorizer'
Plug 'terryma/vim-smooth-scroll'
Plug 'NLKNguyen/papercolor-theme'
" Plug 'vim-airline/vim-airline'
Plug 'itchyny/lightline.vim'
Plug 'josa42/vim-lightline-coc'
Plug 'nvim-treesitter/nvim-treesitter'

" Initialize plugin system
call plug#end()


" SMOOTH_SCROLL_CONFIG
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 20, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 20, 2)<CR>
" END SMOOTH_SCROLL_CONFIG


" COC_CONFIG
" Default extensions
let g:coc_global_extensions = ['coc-json', 'coc-explorer', 'coc-tsserver']

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
" END COC_CONFIG


" GIT_GUTTER_CONFIG
set updatetime=100
" END GIT_GUTTER_CONFIG


" LEADER_MAPPING_CONFIG
let mapleader=" "
nnoremap <SPACE> <Nop>

" Open file tree explorer (N-erdTree)
nmap <Leader>n :CocCommand explorer<CR>

" Open COC Diagnostics (H-elp)
nmap <Leader>h :CocDiagnostics<CR>

" Open file search (Ctrl P)
map <Leader>p :GFiles<CR>

" Open Git status dashboard (G-it)
map <Leader>g :Git<CR>

" For opening Git diff of current file vertically (d-iff)
map <Leader>d :vert Gdiff<CR>

" shortcut for Silver Search (f-ind)
nnoremap <silent> <Leader>f :Ag<cr>
vnoremap <silent> <Leader>f :Ag<cr>

" END LEADER_MAPPING_CONFIG


" VIM_SETTINGS
set number
set autowrite
set smartcase
set ignorecase
set tabstop=2
set shiftwidth=2
set shell=fish
set expandtab
autocmd VimEnter * ColorHighlight
colorscheme PaperColor
set background=light
set cursorline
set foldlevelstart=1
set nofoldenable
let javaScript_fold=1
set hlsearch
set incsearch
set ttimeoutlen=10
set mouse=a
set clipboard+=unnamedplus
set inccommand=nosplit " For viewing live substitution
" END VIM_SETTINGS

" TREE_SITTER_CONFIG
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { },  -- list of language that will be disabled
  },
}
EOF
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
" END TREE_SITTER_CONFIG

" LIGHTLINE_CONFIG
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified', 
      \               'coc_errors', 'coc_warnings', 'coc_ok', 'coc_status' ] ],
      \   'right': [ [ 'gitbranch'  ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" register compoments:
call lightline#coc#register()
" END LIGHTLINE_CONFIG


" AIRLINE_CONFIG
let g:airline_extensions = ['branch','term', 'tabline']
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#close_symbol = '×'
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#term#enabled = 0
" END AIRLINE_CONFIG
