return {
    -- Nvim Treesitter configurations and abstraction layer
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        branch = 'main',
        opts = {
            ensure_installed = {},
            ignore_install = {},
        },
        config = function(_, opts)
            local ts = require('nvim-treesitter')
            ts.setup({ install_dir = vim.fn.stdpath('data') .. '/site/nvim-treesitter' })

            if #opts.ensure_installed > 0 then
                ts.install(opts.ensure_installed)
            end

            vim.api.nvim_create_autocmd('FileType', {
                group = vim.api.nvim_create_augroup('treesitter.setup', {}),
                callback = function(args)
                    local buf = args.buf
                    local filetype = args.match
                    local language = vim.treesitter.language.get_lang(filetype) or filetype

                    -- check if parser is installed
                    if not vim.treesitter.language.add(language) then
                        if require('nvim-treesitter.parsers')[language] then
                            -- parser is not installed, but is supported, automatic install it
                            if not vim.tbl_contains(opts.ignore_install, language) then
                                ts.install(language)
                            end
                        end
                        return
                    end

                    -- folds
                    if vim.treesitter.query.get(language, 'folds') then
                        vim.wo.foldmethod = 'expr'
                        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                        -- open folds by default
                        vim.wo.foldlevel = 99
                        -- vim.o.fillchars = 'fold: '
                        vim.wo.foldtext =
                            [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
                    end

                    -- highlighting
                    vim.treesitter.start(buf, language)

                    -- indent
                    if vim.treesitter.query.get(language, 'indents') then
                        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
            })
        end,
    },

    -- Syntax aware text-objects, select, move, swap, and peek support.
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
        init = function()
            -- Disable entire built-in ftplugin mappings to avoid conflicts.
            -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
            vim.g.no_plugin_maps = true

            -- Or, disable per filetype (add as you like)
            -- vim.g.no_python_maps = true
            -- vim.g.no_ruby_maps = true
            -- vim.g.no_rust_maps = true
            -- vim.g.no_go_maps = true
        end,
        config = function()
            require('nvim-treesitter-textobjects').setup({
                select = {
                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,
                    -- You can choose the select mode (default is charwise 'v')
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * method: eg 'v' or 'o'
                    -- and should return the mode ('v', 'V', or '<c-v>') or a table
                    -- mapping query_strings to modes.
                    selection_modes = {
                        ['@parameter.outer'] = 'v', -- charwise
                        ['@function.outer'] = 'V', -- linewise
                        -- ['@class.outer'] = '<c-v>', -- blockwise
                    },
                    -- If you set this to `true` (default is `false`) then any textobject is
                    -- extended to include preceding or succeeding whitespace. Succeeding
                    -- whitespace has priority in order to act similarly to eg the built-in
                    -- `ap`.
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * selection_mode: eg 'v'
                    -- and should return true of false
                    include_surrounding_whitespace = false,
                },
                move = {
                    -- whether to set jumps in the jumplist
                    set_jumps = true,
                },
            })

            -- buffer-local keymaps, only if parser exists
            vim.api.nvim_create_autocmd('FileType', {
                group = vim.api.nvim_create_augroup('treesitter.textobjects', {}),
                callback = function(args)
                    local buf = args.buf
                    local filetype = args.match
                    local language = vim.treesitter.language.get_lang(filetype) or filetype

                    if not vim.treesitter.language.add(language) then
                        return
                    end

                    local sel = require('nvim-treesitter-textobjects.select')
                    local mov = require('nvim-treesitter-textobjects.move')

                    -- select
                    vim.keymap.set({ 'x', 'o' }, 'af', function()
                        sel.select_textobject('@function.outer', 'textobjects')
                    end, { buffer = buf })
                    vim.keymap.set({ 'x', 'o' }, 'if', function()
                        sel.select_textobject('@function.inner', 'textobjects')
                    end, { buffer = buf })
                    vim.keymap.set({ 'x', 'o' }, 'ac', function()
                        sel.select_textobject('@class.outer', 'textobjects')
                    end, { buffer = buf })
                    vim.keymap.set({ 'x', 'o' }, 'ic', function()
                        sel.select_textobject('@class.inner', 'textobjects')
                    end, { buffer = buf })
                    vim.keymap.set({ 'x', 'o' }, 'a,', function()
                        sel.select_textobject('@parameter.outer', 'textobjects')
                    end, { buffer = buf })
                    vim.keymap.set({ 'x', 'o' }, 'i,', function()
                        sel.select_textobject('@parameter.inner', 'textobjects')
                    end, { buffer = buf })
                    vim.keymap.set({ 'x', 'o' }, 'as', function()
                        sel.select_textobject('@local.scope', 'locals')
                    end, { buffer = buf })

                    -- move
                    vim.keymap.set({ 'n', 'x', 'o' }, ']f', function()
                        mov.goto_next_start('@function.outer', 'textobjects')
                    end, { buffer = buf })
                    vim.keymap.set({ 'n', 'x', 'o' }, ']F', function()
                        mov.goto_next_end('@function.outer', 'textobjects')
                    end, { buffer = buf })
                    vim.keymap.set({ 'n', 'x', 'o' }, '[f', function()
                        mov.goto_previous_start('@function.outer', 'textobjects')
                    end, { buffer = buf })
                    vim.keymap.set({ 'n', 'x', 'o' }, '[F', function()
                        mov.goto_previous_end('@function.outer', 'textobjects')
                    end, { buffer = buf })

                    vim.keymap.set({ 'n', 'x', 'o' }, ']]', function()
                        mov.goto_next_start('@class.outer', 'textobjects')
                    end, { buffer = buf })
                    vim.keymap.set({ 'n', 'x', 'o' }, ']}', function()
                        mov.goto_next_end('@class.outer', 'textobjects')
                    end, { buffer = buf })
                    vim.keymap.set({ 'n', 'x', 'o' }, '[[', function()
                        mov.goto_previous_start('@class.outer', 'textobjects')
                    end, { buffer = buf })
                    vim.keymap.set({ 'n', 'x', 'o' }, '{]', function()
                        mov.goto_previous_end('@class.outer', 'textobjects')
                    end, { buffer = buf })

                    vim.keymap.set({ 'n', 'x', 'o' }, ']s', function()
                        mov.goto_next_start('@local.scope', 'locals')
                    end, { buffer = buf })
                    vim.keymap.set({ 'n', 'x', 'o' }, '[s', function()
                        mov.goto_previous_start('@local.scope', 'locals')
                    end, { buffer = buf })

                    vim.keymap.set({ 'n', 'x', 'o' }, ']z', function()
                        mov.goto_next_start('@fold', 'folds')
                    end, { buffer = buf })
                    vim.keymap.set({ 'n', 'x', 'o' }, '[z', function()
                        mov.goto_previous_start('@fold', 'folds')
                    end, { buffer = buf })
                end,
            })
        end,
    },
}
