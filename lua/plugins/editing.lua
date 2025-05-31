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

    -- enhanced increment/decrement plugin for Neovim.
    {
        'monaqa/dial.nvim',
        keys = {
            { '<C-a>', '<Plug>(dial-increment)', mode = { 'n', 'v' } },
            { '<C-x>', '<Plug>(dial-decrement)', mode = { 'n', 'v' } },
            { 'g<C-a>', 'g<Plug>(dial-increment)', mode = { 'n', 'v' }, remap = true },
            { 'g<C-x>', 'g<Plug>(dial-decrement)', mode = { 'n', 'v' }, remap = true },
        },
        config = function()
            local augend = require('dial.augend')
            require('dial.config').augends:register_group({
                -- default augends used when no group name is specified
                default = {
                    augend.integer.alias.decimal,
                    -- augend.integer.alias.decimal_int, -- including negative number
                    augend.integer.alias.hex,
                    augend.integer.alias.octal,
                    augend.integer.alias.binary,
                    augend.date.alias['%Y/%m/%d'],
                    augend.date.alias['%m/%d/%Y'],
                    augend.date.alias['%d/%m/%Y'],
                    augend.date.alias['%m/%d/%y'],
                    augend.date.alias['%d/%m/%y'],
                    augend.date.alias['%m/%d'],
                    augend.date.alias['%-m/%-d'],
                    augend.date.alias['%Y-%m-%d'],
                    augend.date.alias['%d.%m.%Y'],
                    augend.date.alias['%d.%m.%y'],
                    augend.date.alias['%d.%m.'],
                    augend.date.alias['%-d.%-m.'],
                    augend.date.alias['%Y年%-m月%-d日'],
                    augend.date.alias['%Y年%-m月%-d日(%ja)'],
                    augend.date.alias['%H:%M:%S'],
                    augend.date.alias['%H:%M'],
                    augend.constant.alias.bool,
                    augend.constant.alias.alpha,
                    augend.constant.alias.Alpha,
                    augend.semver.alias.semver,
                    augend.constant.new({
                        elements = { 'True', 'False' },
                        word = true,
                        cyclic = true,
                    }),
                    augend.constant.new({
                        elements = { 'yes', 'no' },
                        word = true,
                        cyclic = true,
                    }),
                    augend.constant.new({
                        elements = { 'and', 'or' },
                        word = true,
                        cyclic = true,
                    }),
                    augend.constant.new({
                        elements = { '&&', '||' },
                        word = false,
                        cyclic = true,
                    }),
                    augend.constant.new({
                        elements = { '&', '|' },
                        word = false,
                        cyclic = true,
                    }),
                    augend.hexcolor.new({ case = 'prefer_upper' }),
                },
            })
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
