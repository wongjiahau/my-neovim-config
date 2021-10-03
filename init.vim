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
" Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'chrisbra/Colorizer'
Plug 'itchyny/lightline.vim'
Plug 'josa42/vim-lightline-coc'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'folke/tokyonight.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
Plug 'nvim-lua/plenary.nvim'
Plug 'windwp/nvim-spectre'
" Plug 'Moqiful/vscode.nvim'

" Initialize plugin system
call plug#end()

" NVIM_SPECTRE_CONFIG
nnoremap <leader>s :lua require('spectre').open()<CR>

"search current highlighted word
vnoremap <leader>s :lua require('spectre').open_visual()<CR>

" END NVIM_SPECTRE_CONFIG

" COC_CONFIG
" Default extensions
let g:coc_global_extensions = ['coc-json', 'coc-explorer', 'coc-tsserver', 'coc-prettier']
let g:coc_enable_locationlist = 0

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

" CLAP_CONFIG
autocmd ColorScheme * hi ClapSearchText guifg=black
autocmd ColorScheme * hi ClapCurrentSelection guifg=black guibg=lightblue
autocmd ColorScheme * hi ClapInput guibg=white
autocmd ColorScheme * hi ClapSpinner guibg=lightgreen guifg=black
autocmd ColorScheme * hi ClapDisplay guibg=white
let g:clap_open_preview = 'never'
" END CLAP_CONFIG

" GIT_GUTTER_CONFIG
set updatetime=100
" END GIT_GUTTER_CONFIG


" LEADER_MAPPING_CONFIG
let mapleader="\\"
" nnoremap <SPACE> <Nop>

" Open file tree explorer (N-erdTree)
nmap <Leader>n :CocCommand explorer<CR>

" Open COC Diagnostics (H-elp)
nmap <Leader>h :CocDiagnostics<CR>

" Open file search (Ctrl P)
map <Leader>p :Clap files<CR>

" Open Git status dashboard (G-it)
map <Leader>g :tab Git<CR>

" For opening Git diff of current file vertically (d-iff)
map <Leader>d :vert Gdiff<CR>

" shortcut for Silver Search (f-ind)
nnoremap <silent> <Leader>f :Clap grep<cr>
vnoremap <silent> <Leader>f :Ag<cr>

" shortcut for putting search result into quickfix
let $FZF_DEFAULT_OPTS = '--bind ctrl-q:select-all+accept'
" END LEADER_MAPPING_CONFIG


" VIM_SETTINGS
set number relativenumber
set autowrite
set smartcase
set ignorecase
set tabstop=2
set shiftwidth=2
set shell=fish
set expandtab
set nowrap
set noswapfile
" autocmd VimEnter * ColorHighlight
colorscheme tokyonight
let g:tokyonight_transparent = 1
" let g:vscode_style = "light"
" colorscheme vscode
set background=light
set cursorline
set cursorcolumn
set hlsearch
set incsearch
set ttimeoutlen=10
set mouse=a
set clipboard+=unnamedplus
set inccommand=nosplit " For viewing live substitution
set guifont=Fira_Code:h28 "Refer https://github.com/glacambre/firenvim/issues/972#issuecomment-797805351
nmap <CR> :wa<CR>

nmap <C-j> :cnext<CR>
nmap <C-k> :cprev<CR>

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

" Make sure all types of *.graphql files get syntax highlighting.
" This is necessary for coc-prettier to work
autocmd BufNewFile,BufRead *.graphql set ft=graphql


