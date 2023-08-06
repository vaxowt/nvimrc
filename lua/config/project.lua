require('project_nvim').setup({
    show_hidden = true,
})

require('telescope').load_extension('projects')

vim.keymap.set(
    'n',
    '<leader>fp',
    '<Cmd>Telescope projects<CR>',
    { noremap = true, silent = true, desc = 'Telescope projects' }
)
