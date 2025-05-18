require('project_nvim').setup({
    show_hidden = true,
    -- FIX: LSP detection method not working. https://github.com/ahmedkhalf/project.nvim/issues/169
    detection_methods = { 'pattern', 'lsp' },
})

require('telescope').load_extension('projects')

vim.keymap.set(
    'n',
    '<leader>fp',
    require('telescope').extensions.projects.projects,
    { noremap = true, silent = true, desc = 'Telescope projects' }
)
