return {
    'luukvbaal/stabilize.nvim',
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
        config = function(_, opts)
            require('possession').setup(opts)

            require('telescope').load_extension('possession')
            vim.keymap.set(
                'n',
                '<leader>fP',
                require('telescope').extensions.possession.list,
                { desc = 'Telescope sessions' }
            )
        end,
    },

    {
        'tyru/open-browser.vim',
        config = function()
            vim.g.netrw_nogx = 1
            vim.keymap.set({ 'n', 'v' }, 'gx', '<Plug>(openbrowser-smart-search)', { desc = 'Open link in browser' })
        end,
    },

    -- Post selections or buffers to online paste bins. Save the URL to a
    -- register, or dont.
    {
        'rktjmp/paperplanes.nvim',
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
        config = function()
            vim.g.translator_history_enable = true
            vim.g.translator_default_engines = { 'haici', 'youdao' }

            vim.keymap.set('n', '<leader>t', '<Plug>TranslateW')

            vim.keymap.set('v', '<leader>t', '<Plug>TranslateWV')

            local grp_translator_colors = vim.api.nvim_create_augroup('grp_translator_colors', { clear = true })
            vim.api.nvim_create_autocmd('ColorScheme', {
                pattern = '*',
                command = [[highlight! def link TranslatorBorder Normal]],
                group = grp_translator_colors,
            })
        end,
    },
}
