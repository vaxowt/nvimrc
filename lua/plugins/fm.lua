return {

    -- Neovim file explorer: edit your filesystem like a buffer
    {
        'stevearc/oil.nvim',
        -- Lazy loading is not recommended because it is very tricky to
        -- make it work correctly in all situations.
        lazy = false,
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {
            delete_to_trash = true,
            keymaps = {
                ['<C-l>'] = { 'actions.select', mode = 'n' },
                ['<C-v>'] = { 'actions.select', opts = { vertical = true } },
                ['<C-s>'] = { 'actions.select', opts = { horizontal = true } },
                ['q'] = { 'actions.close', mode = 'n' },
                ['<C-c>'] = { 'actions.close', mode = 'n' },
                ['<C-r>'] = 'actions.refresh',
                ['<C-h>'] = { 'actions.parent', mode = 'n' },
                ['yp'] = {
                    'actions.yank_entry',
                    mode = 'n',
                    opts = { modify = ':p:.' },
                    desc = 'Yank the relative path',
                },
                ['yP'] = { 'actions.yank_entry', mode = 'n', opts = { modify = ':p' }, desc = 'Yank the absolute path' },
                ['gd'] = {
                    desc = 'Toggle file detail view',
                    callback = function()
                        detail = not detail
                        if detail then
                            require('oil').set_columns({ 'permissions', 'size', 'mtime', 'icon' })
                        else
                            require('oil').set_columns({ 'icon' })
                        end
                    end,
                },
            },
            float = {
                max_width = 0.8,
                max_height = 0.8,
            },
        },
        dependencies = {
            -- { 'echasnovski/mini.icons', opts = {} }
            'nvim-tree/nvim-web-devicons',
            { 'JezerM/oil-lsp-diagnostics.nvim', opts = {} },
            'benomahony/oil-git.nvim',
        },
        keys = {
            { '-', '<cmd>Oil --float<cr>', { desc = 'Oil' } },
        },
    },

    -- A file explorer tree for neovim written in lua
    {
        'nvim-tree/nvim-tree.lua',
        opts = {
            -- use lir.nvim
            hijack_netrw = false,

            -- auto switch cwd, projects.nvim
            sync_root_with_cwd = true,
            respect_buf_cwd = true,
            update_focused_file = {
                enable = true,
                update_root = true,
            },

            renderer = {
                -- show hidden files count
                hidden_display = 'all',
            },
            actions = {
                file_popup = {
                    open_win_config = {
                        border = 'none',
                    },
                },
            },
            filters = {
                -- hide dotfiles by default
                dotfiles = true,
            },
            on_attach = function(bufnr)
                local api = require('nvim-tree.api')
                local function opts(desc)
                    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end

                api.config.mappings.default_on_attach(bufnr)

                vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
                vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
                vim.keymap.del('n', '<C-k>', { buffer = bufnr })
                vim.keymap.del('n', '<C-x>', { buffer = bufnr })
                vim.keymap.set('n', '<C-s>', api.node.open.horizontal, opts('Open: Horizontal Split'))
                vim.keymap.set('n', 'K', api.node.show_info_popup, opts('Info'))
                vim.keymap.set('n', ']d', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
                vim.keymap.set('n', '[d', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
                vim.keymap.set('n', '}', api.node.navigate.sibling.last, opts('Last Sibling'))
                vim.keymap.set('n', '{', api.node.navigate.sibling.first, opts('First Sibling'))
                vim.keymap.set('n', 'N', api.fs.create, opts('Create File Or Directory'))
                vim.keymap.set('n', 'R', api.fs.rename, opts('Rename'))
                vim.keymap.set('n', '<C-r>', api.tree.reload, opts('Rename: Omit Filename'))
                vim.keymap.del('n', 'H', { buffer = bufnr })
                vim.keymap.set('n', '.', api.tree.toggle_hidden_filter, opts('Toggle Filter: Dotfiles'))
                vim.keymap.set('n', '!', api.node.run.cmd, opts('Run Command'))
            end,
        },
        keys = {
            { '<leader>[', '<Cmd>NvimTreeToggle<CR>' },
            { '<leader>{', '<Cmd>NvimTreeFindFile<CR>' },
        },
        cmd = {
            'NvimTreeOpen',
            'NvimTreeToggle',
            'NvimTreeFindFile',
            'NvimTreeFindFileToggle',
        },
    },

    {
        'mikavilpas/yazi.nvim',
        event = 'VeryLazy',
        dependencies = {
            -- check the installation instructions at
            -- https://github.com/folke/snacks.nvim
            'folke/snacks.nvim',
            { 'MagicDuck/grug-far.nvim', opts = {} },
        },
        keys = {
            {
                '<leader>e',
                '<cmd>Yazi<cr>',
                mode = { 'n', 'v' },
                desc = 'Open yazi at the current file',
            },
            {
                -- Open in the current working directory
                '<leader>cw',
                '<cmd>Yazi cwd<cr>',
                desc = "Open the file manager in nvim's working directory",
            },
            {
                '<leader>E',
                '<cmd>Yazi toggle<cr>',
                desc = 'Resume the last yazi session',
            },
        },
        opts = {
            -- use lir.nvim instead
            open_for_directories = false,
            keymaps = {
                show_help = 'g?',
                cycle_open_buffers = 'b',
                grep_in_directory = 'G',
                open_file_in_horizontal_split = '<C-s>',
            },
            floating_window_scaling_factor = 0.8,
            -- highlight_groups = {
            --     -- See https://github.com/mikavilpas/yazi.nvim/pull/180
            --     hovered_buffer = nil,
            --     -- See https://github.com/mikavilpas/yazi.nvim/pull/351
            --     hovered_buffer_in_same_directory = nil,
            -- },
            -- highlight buffers in the same directory as the hovered buffer
            highlight_hovered_buffers_in_same_directory = false,
            integrations = {
                grep_in_directory = 'snacks.picker',
                grep_in_selected_files = 'snacks.picker',
            },
        },
        init = function()
            local yazi_highlights = vim.api.nvim_create_augroup('yazi_highlights', { clear = true })
            vim.api.nvim_create_autocmd('ColorScheme', {
                command = [[highlight! def link YaziFloatBorder Grey]],
                group = yazi_highlights,
            })
        end,
    },
}
