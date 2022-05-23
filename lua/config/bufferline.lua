require('bufferline').setup({
    options = {
        mode = 'tabs',
        show_close_icon = false,
        always_show_bufferline = false,
    },
})

vim.keymap.set('n', '<leader>gt', '<Cmd>BufferLinePick<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gT', '<Cmd>BufferLinePickClose<CR>', { noremap = true, silent = true })
