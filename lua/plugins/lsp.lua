return {
    -- Portable package manager for Neovim that runs everywhere Neovim runs.
    -- Easily install and manage LSP servers, DAP servers, linters, and
    -- formatters.
    {
        'mason-org/mason.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        cmd = 'Mason',
        keys = { { '<leader>M', '<cmd>Mason<cr>', desc = 'Mason' } },
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
        'mason-org/mason-lspconfig.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'mason-org/mason.nvim',
        },
        opts = {
            automatic_installation = true,
        },
    },

    {
        'jay-babu/mason-null-ls.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'mason-org/mason.nvim',
        },
        opts = {
            automatic_installation = true,
        },
    },

    {
        'jay-babu/mason-nvim-dap.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'mason-org/mason.nvim',
        },
        opts = {
            automatic_installation = true,
        },
    },

    -- Quickstart configurations for the Nvim LSP client
    {
        'neovim/nvim-lspconfig',
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
                    formatting.isort,
                    formatting.yapf,
                    -- shell
                    hover.printenv,
                    formatting.shfmt,
                    -- C/C++
                    formatting.clang_format,
                    -- web
                    formatting.prettierd,
                },
            })
        end,
    },

    {
        'dcampos/nvim-snippy',
        event = 'InsertEnter',
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
