return {

    -- A modern vim plugin for editing LaTeX files.
    {
        'lervag/vimtex',
        config = function()
            vim.g.vimtex_view_general_viewer = 'okular'
            vim.g.vimtex_view_general_options = '--unique file:@pdf#src:@line@tex'
        end,
    },

    -- Markdown preview plugin for Neovim
    {
        'toppair/peek.nvim',
        build = 'deno task --quiet build:fast',
        cmd = { 'PeekOpen' },
        keys = {
            {
                '<leader>p',
                '<Cmd>lua require("peek").open()<CR>',
                desc = 'PeekOpen',
            },
        },
        opts = {
            theme = 'light',
        },
        config = function(_, opts)
            require('peek').setup(opts)
            vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
            vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
        end,
    },

    -- Plugin to improve viewing Markdown files in Neovim
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons',
        },
        opts = {
            -- enabled = false,
        },
        cmd = 'RenderMarkdown',
        ft = { 'codecompanion' },
    },

    { 'chrisbra/csv.vim',           ft = 'csv' },

    { 'mtdl9/vim-log-highlighting', ft = 'log' },
}
