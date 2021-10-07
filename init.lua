local o = vim.o
local wo = vim.wo
local bo = vim.bo
local g = vim.g
function nnoremap(key, cmd)
  vim.api.nvim_set_keymap('n', key, cmd, { noremap = true })
end
function vnoremap(key, cmd)
  vim.api.nvim_set_keymap('v', key, cmd, { noremap = true })
end


-- Bootstrap packer, refer https://github.com/wbthomason/packer.nvim#bootstrapping
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end


return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {'neoclide/coc.nvim', branch = 'release'}
  g.coc_global_extensions = {'coc-json', 'coc-explorer', 'coc-tsserver', 'coc-prettier'}
  -- Open file tree explorer (N-erdTree)
  nnoremap('<Leader>n', ':CocCommand explorer<CR>')
  g.coc_enable_locationlist = 0
  -- Make sure all types of *.graphql files get syntax highlighting.
  -- This is necessary for coc-prettier to work
  vim.cmd('autocmd BufNewFile,BufRead *.graphql set ft=graphql')
  vim.cmd [[
    nmap gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
    nmap <silent> gh :call Show_documentation()<CR>
    nmap <silent> <Leader>, :CocAction<CR>
    nmap <Leader>r <Plug>(coc-rename)

    function! Show_documentation()
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

    " Press Enter to use the first suggestion
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  ]]



  use 'chrisbra/Colorizer'

  use 'itchyny/lightline.vim'
  use 'josa42/vim-lightline-coc'
  g.lightline = {
    active = {
      left = {
        { 'paste' },
        { 'readonly', 'relativepath', 'modified', 
        'coc_errors', 'coc_warnings', 'coc_ok', 'coc_status' } },
        right = { { 'gitbranch'  } }
      },
    component_function = {
      gitbranch = 'FugitiveHead'
    },
  }
  vim.cmd('call lightline#coc#register()')

  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  -- Open [g]it dashboard 
  nnoremap('<Leader>g', ':tab Git<CR>')
  -- For opening Git [d]iff of current file vertically 
  nnoremap('<Leader>d', ':vert Gdiff<CR>')

  use 'tpope/vim-surround'
  use 'folke/tokyonight.nvim'
  vim.cmd('colorscheme tokyonight')
  g.tokyonight_transparent = 1

  use 'nvim-lua/plenary.nvim'

  use 'windwp/nvim-spectre'
  -- [s]earch and replace
  nnoremap('<leader>s', ':lua require("spectre").open() <CR>')
  -- [s]earch current highlighted word
  vnoremap('<leader>s', ':lua require("spectre").open_visual() <CR>')

  use 'nvim-telescope/telescope.nvim'
  -- Open file search
  nnoremap('<Leader>p', ':Telescope git_files<CR>')
  -- Open [b]uffer search
  nnoremap('<Leader>b', ':Telescope buffers<CR>')
  -- Global [f]ind
  nnoremap('<Leader>f', ':Telescope live_grep<cr>')

  use 'kyazdani42/nvim-web-devicons'
  use 'sindrets/diffview.nvim'

  require('diffview').setup({
    file_panel = {
      tree_options = {
        flatten_dirs = false
      }
    }
  })
  -- Open current file [h]istory
  nnoremap('<Leader>h', ':DiffviewFileHistory<CR>')

  use { 
    'TimUntersberger/neogit', 
    requires = 'nvim-lua/plenary.nvim',
  }
  require('neogit').setup({
    integrations = {
      diffview = true
    }
  })

  use {
    "nanozuki/tabby.nvim",
    requires = "kyazdani42/nvim-web-devicons"
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  require('nvim-treesitter.configs').setup({
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
      enable = true,              -- false will disable the whole extension
      disable = { },  -- list of language that will be disabled
    },
  })


  -- generic mappings
  nnoremap('<CR>', ':wa<CR>')
  nnoremap('<C-j>', ':cnext<CR>')
  nnoremap('<C-k>', ':cprev<CR>')

  -- vim settings
  o.clipboard = o.clipboard .. 'unnamedplus'
  o.number = true
  o.relativenumber = true
  o.autowrite = true
  o.smartcase = true
  o.ignorecase = true
  o.tabstop = 2
  o.shiftwidth = 2
  o.shell = 'fish'
  o.expandtab = true
  o.wrap = false
  o.swapfile = false
  o.background = 'light'
  o.cursorline = true
  o.cursorcolumn = true
  o.hlsearch = true
  o.incsearch = true
  o.ttimeoutlen = 10
  o.mouse = 'a'
  o.inccommand = 'nosplit' -- For viewing live substitution

end)

