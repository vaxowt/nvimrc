return {

    -- A modern vim plugin for editing LaTeX files.
    {
        'lervag/vimtex',
        init = function()
            vim.g.vimtex_view_general_viewer = 'okular'
            vim.g.vimtex_view_general_options = '--unique file:@pdf#src:@line@tex'
        end,
    },

    -- Live Markdown preview for Neovim with Mermaid diagrams,
    -- LaTeX math (KaTeX), scroll sync, and syntax highlighting.
    -- Pure Lua, zero npm dependencies.
    {
        'selimacerbas/markdown-preview.nvim',
        dependencies = { 'selimacerbas/live-server.nvim' },
        opts = {
            default_theme = "light",
        },
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
            file_types = { 'codecompanion' },
        },
        cmd = 'RenderMarkdown',
        ft = { 'codecompanion' },
    },

    -- A csv filetype plugin.
    { 'chrisbra/csv.vim', ft = 'csv' },

    -- Syntax highlighting for generic log files in VIM.
    { 'mtdl9/vim-log-highlighting', ft = 'log' },
}
