require('persisted').setup({
    use_git_branch = true,
})

require('telescope').load_extension('persisted')

vim.keymap.set('n', '<leader>fP', '<Cmd>Telescope persisted<CR>')
