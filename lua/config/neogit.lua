require('neogit').setup({
    integrations = {
        diffview = true,
    },
})

vim.keymap.set('n', '<leader>G', '<Cmd>Neogit<CR>', { noremap = true, silent = true })
