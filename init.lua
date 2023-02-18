-- HACK: lazy.nvim requires to set `mapleader` first
vim.g.mapleader = ' '

require('plugins')
require('options')
require('mappings')
require('autocmds')
