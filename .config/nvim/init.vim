call plug#begin(stdpath('data') . '/plugged')

Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

call plug#end()

lua << END
require('lualine').setup{
options = {theme = 'gruvbox'}
}
END

set number
