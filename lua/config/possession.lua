require('possession').setup({
    autosave = {
        current = true,
    },
    commands = {
        save = 'Ssave',
        load = 'Sload',
        delete = 'Sdelete',
        show = 'Sshow',
        list = 'Slist',
        migrate = 'Smigrate',
    },
})

require('telescope').load_extension('possession')
vim.keymap.set('n', '<leader>fP', require('telescope').extensions.possession.list)
