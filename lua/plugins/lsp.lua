return {
    -- Portable package manager for Neovim that runs everywhere Neovim runs.
    -- Easily install and manage LSP servers, DAP servers, linters, and
    -- formatters.
    {
        'williamboman/mason.nvim',
        opts = {
            ui = {
                icons = {
                    server_installed = '✓',
                    server_pending = '➜',
                    server_uninstalled = '✗',
                },
            },
        },
    },
    {
        'williamboman/mason-lspconfig.nvim',
        opts = {
            automatic_installation = true,
        },
    },
    {
        'jay-babu/mason-null-ls.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {
            automatic_installation = true,
        },
    },
    {
        'jay-babu/mason-nvim-dap.nvim',
        opts = {
            automatic_installation = true,
        },
    },

    -- Quickstart configurations for the Nvim LSP client
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'mason-lspconfig.nvim' },
    },

    -- null-ls.nvim reloaded / Use Neovim as a language server to inject LSP
    -- diagnostics, code actions, and more via Lua.
    {
        'nvimtools/none-ls.nvim',
        config = function()
            local none_ls = require('null-ls')

            -- code action sources
            -- local code_actions = none_ls.builtins.code_actions

            -- diagnostic sources
            -- local diagnostics = none_ls.builtins.diagnostics

            -- formatting sources
            local formatting = none_ls.builtins.formatting

            -- hover sources
            local hover = none_ls.builtins.hover

            -- completion sources
            -- local completion = none_ls.builtins.completion

            none_ls.setup({
                sources = {
                    -- general
                    -- completion.spell,
                    -- lua
                    formatting.stylua,
                    -- python
                    formatting.yapf,
                    formatting.isort,
                    -- shell
                    hover.printenv,
                },
            })
        end,
    },

    {
        'dcampos/nvim-snippy',
        opts = {
            mappings = {
                is = {
                    ['<C-j>'] = 'expand_or_advance',
                    ['<C-k>'] = 'previous',
                },
            },
        },
    },

    { 'honza/vim-snippets' },
}
