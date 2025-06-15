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
            -- stylua: ignore start
            { '<leader>aa', '<CMD>CodeCompanion<CR>', mode = { 'n', 'v' }, desc = 'ai: codecompanion' },
            { '<leader>ae', '<CMD>CodeCompanion /explain<CR>', mode = { 'n', 'v' }, desc = 'ai: codecompanion /explain' },
            { '<leader>am', '<CMD>CodeCompanion /commit<CR>', mode = { 'n', 'v' }, desc = 'ai: codecompanion /commit' },
            { '<leader>ac', '<CMD>CodeCompanionChat<CR>', mode = { 'n', 'v' }, desc = 'ai: codecompanion chat' },
            { '<leader>ai', '<CMD>CodeCompanionChat Add<CR>', mode = 'v', desc = 'ai: codecompanion chat' },
            -- stylua: ignore stop
        },
        cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionActions' },
    },
}
