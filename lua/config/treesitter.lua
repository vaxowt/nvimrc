require('nvim-treesitter.configs').setup({
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
        enable = false,
        keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
        },
    },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
                ['a,'] = '@parameter.outer',
                ['i,'] = '@parameter.inner',
            },
        },
    },
})

vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
-- open folds by default
vim.o.foldlevel = 99
-- vim.o.fillchars = 'fold: '
vim.o.foldtext =
    [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
