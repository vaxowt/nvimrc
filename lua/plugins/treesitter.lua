return {
    -- Nvim Treesitter configurations and abstraction layer
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',
        opts = {
            ensure_installed = {},
            ignore_install = { 'latex' },
            auto_install = true,
            sync_install = false,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
                -- disable = function (_, bufnr)
                --     return vim.api.nvim_buf_line_count(bufnr) > 10000
                -- end,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<C-n>',
                    node_incremental = '<C-n>',
                    scope_incremental = '<C-s>',
                    node_decremental = '<BS>',
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['ac'] = '@class.outer',
                        ['ic'] = '@class.inner',
                        ['a,'] = '@parameter.outer',
                        ['i,'] = '@parameter.inner',
                        ['as'] = { query = '@local.scope', query_group = 'locals', desc = 'Select language scope' },
                    },
                },
            },
        },
        main = 'nvim-treesitter.configs',
        init = function()
            vim.o.foldmethod = 'expr'
            vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            -- open folds by default
            vim.o.foldlevel = 99
            -- vim.o.fillchars = 'fold: '
            vim.o.foldtext =
                [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
        end,
    },
}
