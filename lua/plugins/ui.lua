return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons' },
        opts = {
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = { left = '|', right = '|' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {},
                always_divide_middle = true,
                globalstatus = false,
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = {
                    'branch',
                    'diff',
                    {
                        'diagnostics',
                        symbols = { error = ' ', warn = ' ', hint = ' ', info = ' ' },
                        colored = false,
                    },
                },

                lualine_c = { 'filename' },
                lualine_x = { 'encoding', 'fileformat', { 'filetype', colored = false } },
                lualine_y = { 'progress' },
                lualine_z = { 'location' },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            extensions = {},
        },
    },

    {
        'hedyhli/outline.nvim',
        cmd = { 'Outline', 'OutlineOpen' },
        keys = {
            { '<leader>]', '<cmd>Outline<CR>', desc = 'Toggle outline' },
        },
        opts = {},
    },

    {
        'gorbit99/codewindow.nvim',
        cmd = 'Minimap',
        config = function()
            require('codewindow').setup({})

            vim.api.nvim_create_user_command('Minimap', require('codewindow').toggle_minimap, {})
        end,
    },

    {
        'akinsho/bufferline.nvim',
        dependencies = 'kyazdani42/nvim-web-devicons',
        opts = {
            options = {
                mode = 'tabs',
                show_close_icon = false,
                always_show_bufferline = false,
            },
        },
        config = function(_, opts)
            require('bufferline').setup(opts)

            vim.keymap.set(
                'n',
                '<leader>gt',
                '<Cmd>BufferLinePick<CR>',
                { noremap = true, silent = true, desc = 'Pick a buffer by typing the character' }
            )
            vim.keymap.set(
                'n',
                '<leader>gT',
                '<Cmd>BufferLinePickClose<CR>',
                { noremap = true, silent = true, desc = 'Close a buffer by typing the character' }
            )
        end,
    },

    {
        'lewis6991/gitsigns.nvim',
        opts = {
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- navigation
                map('n', ']c', function()
                    if vim.wo.diff then
                        return ']c'
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return '<Ignore>'
                end, { expr = true, desc = '[git] Goto next hunk' })

                map('n', '[c', function()
                    if vim.wo.diff then
                        return '[c'
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return '<Ignore>'
                end, { expr = true, desc = '[git] goto previous hunk' })

                -- actions
                map('n', '<leader>gr', gs.reset_hunk, { desc = '[git] reset hunk' })
                map('n', '<leader>gp', gs.preview_hunk, { desc = '[git] preview hunk' })
                map('n', '<leader>gb', function()
                    gs.blame_line({ full = true })
                end, { desc = '[git] blame line' })
                map('n', '<leader>gB', gs.toggle_current_line_blame, { desc = '[git] toggle current line blame' })
                map('n', '<leader>gd', gs.diffthis, { desc = '[git] diffthis' })
                map('n', '<leader>gD', function()
                    gs.diffthis('~')
                end, { desc = '[git] diffthis file' })

                -- text object
                map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
            end,
        },
    },

    {
        'sindrets/diffview.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        config = true,
        cmd = { 'DiffviewOpen' },
    },

    {
        'TimUntersberger/neogit',
        cmd = 'Neogit',
        keys = { { '<leader>G', '<Cmd>Neogit<CR>', desc = 'Neogit' } },
        dependencies = 'nvim-lua/plenary.nvim',
        opts = {
            integrations = {
                diffview = true,
            },
        },
    },

    -- (Neo)Vim plugin for automatically highlighting other uses of the word
    -- under the cursor using either LSP, Tree-sitter, or regex matching.
    {
        'RRethy/vim-illuminate',
        config = function()
            require('illuminate').configure({
                filetypes_denylist = { 'hex', 'lir', 'csv', 'log', 'text' },
            })
        end,
    },

    -- A Neovim plugin hiding your colorcolumn when unneeded.
    {
        'm4xshen/smartcolumn.nvim',
        opts = {
            disabled_filetypes = { 'lazy', 'mason', 'null-ls-info' },
        },
    },

    {
        'akinsho/toggleterm.nvim',
        config = function()
            require('toggleterm').setup({
                open_mapping = [[<M-z>]],
                hide_numbers = true,
            })

            function _G.set_terminal_keymaps()
                local opts = { buffer = 0 }
                vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
                vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
                vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
                vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
                vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
                vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
                vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
            end

            -- if you only want these mappings for toggle term use term://*toggleterm#* instead
            vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
        end,
    },

    -- Indent guides for Neovim
    {
        'lukas-reineke/indent-blankline.nvim',
        event = 'BufReadPost',
        main = 'ibl',
        opts = {
            indent = {
                char = '┆',
                -- highlight = { 'Function', 'Label' },
            },
            scope = {
                -- highlight = { 'Function', 'Label' },
            },
        },
    },

    -- Better quickfix window in Neovim, polish old quickfix window.
    {
        'kevinhwang91/nvim-bqf',
        opts = {
            auto_resize_height = true,
        },
    },

    -- Hlsearch Lens for Neovim
    {
        'kevinhwang91/nvim-hlslens',
        opts = {
            -- vim-cool is not needed anymore
            calm_down = true,
            nearest_only = true,
        },
        config = function(_, opts)
            require('hlslens').setup(opts)

            local kopts = { noremap = true, silent = true }

            vim.api.nvim_set_keymap(
                'n',
                'n',
                [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
                kopts
            )
            vim.api.nvim_set_keymap(
                'n',
                'N',
                [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
                kopts
            )
            vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
            vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
            vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
            vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

            vim.api.nvim_set_keymap('n', '<Leader>l', '<Cmd>noh<CR>', kopts)
        end,
    },

    {
        'folke/todo-comments.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        -- HACK: prevent breaking start screen.
        -- https://github.com/folke/todo-comments.nvim/issues/133#issuecomment-1533670710
        event = 'VimEnter',
        opts = {},
    },
}
