require('plugins')
local o = vim.o
local wo = vim.wo
local bo = vim.bo
local g = vim.g
local function nnoremap(key, cmd)
  vim.api.nvim_set_keymap('n', key, cmd, { noremap = true })
end
local function vnoremap(key, cmd)
  vim.api.nvim_set_keymap('v', key, cmd, { noremap = true })
end


-- Tree sitter settings
require('nvim-treesitter.configs').setup({
  autotag = {
    enable = true
  },
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { },  -- list of language that will be disabled
  },
})

-- Autopair settings
require('nvim-autopairs').setup({})

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

-- lualine settings
require('lualine').setup({ 
  sections = {
    lualine_a = {{'filename', path = 1}},
    lualine_b = {'g:coc_status'},
    lualine_c = {{'diagnostics', sources = {'coc'}}},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {'branch'}
  },
})

-- diffview settings
require('diffview').setup({
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

-- https://github.com/alvarosevilla95/luatab.nvim
vim.o.tabline = '%!v:lua.require\'luatab\'.tabline()'

-- key mappings
nnoremap('<CR>', ':wa<CR>')
nnoremap('<C-j>', ':cnext<CR>')
nnoremap('<C-k>', ':cprev<CR>')
-- Open [g]it dashboard 
nnoremap('<Leader>g', ':Neogit<CR>')
-- Open [G]it diffs 
nnoremap('<Leader>G', ':DiffviewOpen<CR>')
-- For opening Git [d]iff of current file vertically 
nnoremap('<Leader>d', ':vert Gdiff<CR>')
-- [s]earch and replace
nnoremap('<leader>s', ':lua require("spectre").open() <CR>')
-- [s]earch current highlighted word
vnoremap('<leader>s', ':lua require("spectre").open_visual() <CR>')
-- Open file search (follows VSCode Cmd+p)
nnoremap('<Leader>p', ':Telescope git_files<CR>')
-- Open command pallete (follows VSCode Cmd+shift+p)
nnoremap('<Leader>P', ':Telescope commands<CR>')
-- Open registers search
nnoremap('<Leader>"', ':Telescope registers<CR>')
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
o.hidden = true -- to ensure terminal remains alive
o.background = 'light'


require('github-theme').setup({
  theme_style = 'light_default',
  transparent = true,
  hide_inactive_statusline = false
})


