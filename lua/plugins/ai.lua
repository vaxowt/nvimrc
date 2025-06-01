return {
    {
        'olimorris/codecompanion.nvim',
        opts = {},
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            { 'zbirenbaum/copilot.lua', opts = {}, cmd = 'Copilot' },
        },
        keys = {
            { '<leader>aa', '<CMD>CodeCompanion<CR>', mode = { 'n', 'v' }, desc = 'Code Companion' },
            {
                '<leader>ae',
                '<CMD>CodeCompanion /explain<CR>',
                mode = { 'n', 'v' },
                desc = 'Code Companion /explain',
            },
            {
                '<leader>am',
                '<CMD>CodeCompanion /commit<CR>',
                mode = { 'n', 'v' },
                desc = 'Code Companion /commit',
            },
            { '<leader>ac', '<CMD>CodeCompanionChat<CR>', mode = { 'n', 'v' }, desc = 'Code Companion Chat' },
            {
                '<leader>ai',
                '<CMD>CodeCompanionChat Add<CR>',
                mode = 'v',
                desc = 'Code Companion Chat',
            },
        },
        cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionActions' },
    },
}
