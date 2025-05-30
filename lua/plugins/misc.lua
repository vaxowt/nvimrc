return {

    { 'dstein64/vim-startuptime', cmd = 'StartupTime' },

    {
        'jedrzejboczar/possession.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
        },
        opts = {
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
        },
        cmd = { 'Ssave', 'Sload', 'Sdelete', 'Sshow', 'Slist', 'Smigrate' },
        config = function(_, opts)
            require('possession').setup(opts)

            require('telescope').load_extension('possession')
        end,
        keys = {
            { '<leader>fP', '<CMD>Telescope possession<CR>', desc = 'Telescope: sessions' },
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
}
