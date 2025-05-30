return {
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        opts = {},
    },

    {
        'numToStr/Comment.nvim',
        opts = {
            ignore = '^$',
        },
    },

    -- A (Neo)vim plugin for formatting code.
    {
        'sbdchd/neoformat',
        cmd = 'Neoformat',
        keys = { { '<leader>F', '<Cmd>Neoformat<CR>', desc = 'Neoformat' } },
        init = function()
            vim.g.neoformat_basic_format_align = 1
            vim.g.neoformat_basic_format_trim = 1
            vim.g.neoformat_basic_format_retab = 1
        end,
    },

    {
        'kylechui/nvim-surround',
        opts = {},
    },

    --  A Vim alignment plugin
    {
        'junegunn/vim-easy-align',
        config = function()
            vim.keymap.set({ 'x', 'n' }, 'ga', '<Plug>(EasyAlign)')
            vim.keymap.set('v', '<CR>', '<Plug>(EasyAlign)')
        end,
    },

    { 'tpope/vim-repeat' },

    -- 『盘古之白』中文排版自动规范化的 Vim 插件
    { 'hotoo/pangu.vim', cmd = 'Pangu' },

    -- Neovim plugin to expand incrementing/decrementing to more formats.
    {
        'zegervdv/nrpattern.nvim',
        config = function()
            local patterns = require('nrpattern.default')

            patterns[{ 'True', 'False' }] = { priority = 5 }
            patterns[{ 'yes', 'no' }] = { priority = 5 }

            require('nrpattern').setup(patterns)
        end,
    },

    -- Toogle comma(,), semicolon(;) or other character in neovim
    {
        'saifulapm/commasemi.nvim',
        init = function()
            vim.g.commasemi_disable_commands = true
        end,
        opts = {
            commands = false,
        },
    },
}
