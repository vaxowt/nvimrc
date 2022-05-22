require('neogit').setup({
    integration = {
        diffview = true,
    },
})

vim.keymap.set('n', '<leader>G', '<Cmd>Neogit<CR>', { noremap = true, silent = true })
