require('plugins')
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


-- Tree sitter settings
require('nvim-treesitter.configs').setup({
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { },  -- list of language that will be disabled
  },
})

-- COC settings
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

-- lightline settings
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

-- diffview settings
require('diffview').setup({
  enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
  file_panel = {
    position = 'top',
    height = 6,
    tree_options = {
      flatten_dirs = false
    }
  }
})

-- neogit settings
require('neogit').setup({
  disable_commit_confirmation = true,
  integrations = {
    diffview = true
  }
})

-- key mappings
nnoremap('<CR>', ':wa<CR>')
nnoremap('<C-j>', ':cnext<CR>')
nnoremap('<C-k>', ':cprev<CR>')
-- Open [g]it dashboard 
nnoremap('<Leader>g', ':Neogit<CR>')
-- For opening Git [d]iff of current file vertically 
nnoremap('<Leader>d', ':vert Gdiff<CR>')
-- [s]earch and replace
nnoremap('<leader>s', ':lua require("spectre").open() <CR>')
-- [s]earch current highlighted word
vnoremap('<leader>s', ':lua require("spectre").open_visual() <CR>')
-- Open file search
nnoremap('<Leader>p', ':Telescope git_files<CR>')
-- Open [b]uffer search
nnoremap('<Leader>b', ':Telescope buffers<CR>')
-- Global [f]ind
nnoremap('<Leader>f', ':Telescope live_grep<cr>')
-- Open current file [h]istory
nnoremap('<Leader>h', ':DiffviewFileHistory<CR>')




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
o.cursorline = true
o.cursorcolumn = true
o.hlsearch = true
o.incsearch = true
o.ttimeoutlen = 10
o.mouse = 'a'
o.inccommand = 'nosplit' -- For viewing live substitution
g.tokyonight_transparent = 1
vim.cmd('colorscheme tokyonight')


