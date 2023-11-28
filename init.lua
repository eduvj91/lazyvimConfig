require('config.options')
require('config.keymaps')
require('config.autocmd')
require('config.lazy')

pcall(vim.cmd.colorscheme, 'nightfly')
