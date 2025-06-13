return {

    { 'dstein64/vim-startuptime', cmd = 'StartupTime' },

    {
        'stevearc/resession.nvim',
        config = function()
            local resession = require('resession')
            resession.setup({})

            -- Automatically save sessions on by working directory on exit
            vim.api.nvim_create_autocmd('VimLeavePre', {
                callback = function()
                    resession.save(vim.fn.getcwd(), { notify = true })
                end,
            })

            -- -- Automatically load sessions on startup by working directory
            -- vim.api.nvim_create_autocmd('VimEnter', {
            --     callback = function()
            --         -- Only load the session if nvim was started with no args
            --         if vim.fn.argc(-1) == 0 then
            --             resession.load(vim.fn.getcwd(), { silence_errors = true })
            --         end
            --     end,
            --     nested = true,
            -- })
        end,
    },

    {
        'scottmckendry/pick-resession.nvim',
        dependencies = { 'folke/snacks.nvim' },
        keys = {
            {
                '<leader>sr',
                function()
                    require('pick-resession').pick()
                end,
                mode = { 'n', 'v' },
                desc = 'Pick a resession to load',
            },
        },
    },

    {
        'tyru/open-browser.vim',
        init = function()
            vim.g.netrw_nogx = 1
        end,
        keys = {
            { 'gx', '<Plug>(openbrowser-smart-search)', mode = { 'n', 'v' }, desc = 'Open link in browser' },
        },
    },

    -- Post selections or buffers to online paste bins. Save the URL to a
    -- register, or dont.
    {
        'rktjmp/paperplanes.nvim',
        cmd = 'PP',
        opts = {
            register = '+',
            provider = '0x0.st',
            provider_options = {},
            cmd = 'curl',
        },
    },

    -- Asynchronous translating plugin for Vim/Neovim
    {
        'voldikss/vim-translator',
        init = function()
            vim.g.translator_history_enable = true
            vim.g.translator_default_engines = { 'haici', 'youdao' }
        end,
        cmd = { 'Translate', 'TranslateW', 'TranslateR', 'TranslateH', 'TranslateL' },
        keys = {
            { '<leader>t', '<Plug>TranslateW', mode = 'n', desc = 'Translate the word under the cursor' },
            { '<leader>t', '<Plug>TranslateWV', mode = 'v', desc = 'Translate the selection' },
        },
        config = function()
            local grp_translator_colors = vim.api.nvim_create_augroup('grp_translator_colors', { clear = true })
            vim.api.nvim_create_autocmd('ColorScheme', {
                pattern = '*',
                command = [[highlight! def link TranslatorBorder Normal]],
                group = grp_translator_colors,
            })
        end,
    },

    -- A collection of QoL plugins for Neovim
    {
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        opts = {
            bigfile = { enabled = true },
            indent = { enabled = true },
            notifier = { enabled = true },
        },
    },

    {
        'propet/toggle-fullscreen.nvim',
        keys = {
            {
                '<leader>wm',
                function()
                    require('toggle-fullscreen'):toggle_fullscreen()
                end,
                desc = 'toggle-fullscreen',
            },
        },
    },
}
