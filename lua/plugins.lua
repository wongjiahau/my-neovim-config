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
  use 'chrisbra/Colorizer'
  use 'itchyny/lightline.vim'
  use 'josa42/vim-lightline-coc'
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'folke/tokyonight.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'windwp/nvim-spectre'
  use 'nvim-telescope/telescope.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'sindrets/diffview.nvim'  
  use { 
    'TimUntersberger/neogit', 
    requires = 'nvim-lua/plenary.nvim',
  }
  use {
    "nanozuki/tabby.nvim",
    requires = "kyazdani42/nvim-web-devicons"
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

end)
