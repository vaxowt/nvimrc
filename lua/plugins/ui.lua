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
        event = 'BufWinEnter',
        keys = {
            {
                '<leader>gt',
                '<Cmd>BufferLinePick<CR>',
                desc = 'Pick a buffer by typing the character',
            },
            {
                '<leader>gT',
                '<Cmd>BufferLinePickClose<CR>',
                desc = 'Close a buffer by typing the character',
            },
        },
    },

    -- BUG: not compatible with codecompanion
    -- -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
    -- {
    --     'folke/noice.nvim',
    --     event = 'VeryLazy',
    --     opts = {
    --         -- add any options here
    --     },
    --     dependencies = {
    --         -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    --         'MunifTanjim/nui.nvim',
    --         -- OPTIONAL:
    --         --   `nvim-notify` is only needed, if you want to use the notification view.
    --         --   If not available, we use `mini` as the fallback
    --         'rcarriga/nvim-notify',
    --     },
    -- },

    {
        {
            'Bekaboo/dropbar.nvim',
            -- optional, but required for fuzzy finder support
            dependencies = {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
            },
            config = function()
                local dropbar_api = require('dropbar.api')
                vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
                vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
                vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
            end,
        },
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
        opts = {},
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
        opts = {
            open_mapping = [[<M-z>]],
            hide_numbers = true,
        },
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
