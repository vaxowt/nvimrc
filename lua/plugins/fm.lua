return {
    {
        'tamago324/lir.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'kyazdani42/nvim-web-devicons',
        },
        config = function()
            local actions = require('lir.actions')
            local mark_actions = require('lir.mark.actions')
            local clipboard_actions = require('lir.clipboard.actions')

            require('lir').setup({
                show_hidden_files = false,
                devicons = {
                    enable = true,
                    highlight_dirname = false,
                },
                hide_cursor = true,
                mappings = {
                    ['l'] = actions.edit,
                    ['<C-x>'] = actions.split,
                    ['<C-v>'] = actions.vsplit,
                    ['<C-t>'] = actions.tabedit,

                    ['h'] = actions.up,
                    ['-'] = actions.up,
                    ['q'] = actions.quit,
                    ['<esc>'] = actions.quit,

                    ['cd'] = actions.cd,

                    ['K'] = actions.mkdir,
                    ['N'] = actions.newfile,
                    ['R'] = actions.rename,
                    ['Y'] = actions.yank_path,
                    ['.'] = actions.toggle_show_hidden,
                    ['D'] = actions.delete,

                    ['J'] = function()
                        mark_actions.toggle_mark('n')
                        vim.cmd('normal! j')
                    end,
                    ['C'] = clipboard_actions.copy,
                    ['X'] = clipboard_actions.cut,
                    ['P'] = clipboard_actions.paste,
                },
                float = {
                    winblend = 0,
                    curdir_window = {
                        enable = true,
                        highlight_dirname = true,
                    },

                    -- You can define a function that returns a table to be passed as the third
                    -- argument of nvim_open_win().
                    win_opts = function()
                        local width = math.floor(vim.o.columns * 0.6)
                        local height = math.floor(vim.o.lines * 0.6)
                        return {
                            border = {
                                '╭',
                                '─',
                                '╮',
                                '│',
                                '╯',
                                '─',
                                '╰',
                                '│',
                            },
                            width = width,
                            height = height,
                            row = math.floor((vim.o.lines - height) / 2),
                            col = math.floor((vim.o.columns - width) / 2),
                        }
                    end,
                },
                on_init = function()
                    -- use visual mode
                    vim.keymap.set(
                        'x',
                        'J',
                        [[:<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>]],
                        { noremap = true, silent = true, buffer = true }
                    )

                    -- echo cwd
                    -- vim.api.nvim_echo({ { vim.fn.expand('%:p'), 'Normal' } }, false, {})
                end,
            })

            -- custom folder icon
            require('nvim-web-devicons').set_icon({
                lir_folder_icon = {
                    icon = '',
                    color = '#7ebae4',
                    name = 'LirFolderNode',
                },
            })

            vim.keymap.set(
                'n',
                '-',
                require('lir.float').toggle,
                { noremap = true, silent = true, desc = 'Open lir file manager' }
            )

            local lir_highlights = vim.api.nvim_create_augroup('lir_highlights', { clear = true })
            vim.api.nvim_create_autocmd('ColorScheme', {
                command = [[highlight! LirTransparentCursor gui=strikethrough blend=100]],
                group = lir_highlights,
            })
            vim.api.nvim_create_autocmd('ColorScheme', {
                command = [[highlight! def link LirFloatBorder Grey]],
                group = lir_highlights,
            })
        end,
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
