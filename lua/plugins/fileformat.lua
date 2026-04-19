return {

    -- A modern vim plugin for editing LaTeX files.
    {
        'lervag/vimtex',
        init = function()
            vim.g.vimtex_view_general_viewer = 'okular'
            vim.g.vimtex_view_general_options = '--unique file:@pdf#src:@line@tex'
        end,
    },

    -- TODO: deprecated, replace with markdown-preview.nvim
    -- Markdown preview plugin for Neovim
    {
        'toppair/peek.nvim',
        build = 'deno task --quiet build:fast',
        cmd = { 'PeekOpen' },
        keys = {
            -- {
            --     '<leader>p',
            --     '<Cmd>lua require("peek").open()<CR>',
            --     desc = 'PeekOpen',
            -- },
        },
        opts = {
            theme = 'light',
            app = { 'chromium', '--new-window' },
        },
        config = function(_, opts)
            require('peek').setup(opts)
            vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
            vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
        end,
    },

    -- Live Markdown preview for Neovim with Mermaid diagrams,
    -- LaTeX math (KaTeX), scroll sync, and syntax highlighting. 
    -- Pure Lua, zero npm dependencies.
    {
        'selimacerbas/markdown-preview.nvim',
        dependencies = { 'selimacerbas/live-server.nvim' },
        opts = {},
        keys = {
            { '<leader>p', '<cmd>MarkdownPreview<cr>', desc = 'markdown: start preview' },
        },
        cmd = { 'MarkdownPreview', 'MarkdownPreviewRefresh', 'MarkdownPreviewStop' },
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

    { 'chrisbra/csv.vim', ft = 'csv' },

    { 'mtdl9/vim-log-highlighting', ft = 'log' },
}
