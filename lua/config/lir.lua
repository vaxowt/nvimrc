local actions = require('lir.actions')
local mark_actions = require('lir.mark.actions')
local clipboard_actions = require('lir.clipboard.actions')

require('lir').setup({
    show_hidden_files = false,
    devicons_enable = true,
    hide_cursor = true,
    mappings = {
        ['l'] = actions.edit,
        ['<C-s>'] = actions.split,
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
        vim.api.nvim_echo({ { vim.fn.expand('%:p'), 'Normal' } }, false, {})
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

vim.keymap.set('n', '<leader>e', "<Cmd>lua require('lir.float').toggle()<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '-', "<Cmd>lua require('lir.float').toggle()<CR>", { noremap = true, silent = true })

local lir_highlights = vim.api.nvim_create_augroup('lir_highlights', { clear = true })
vim.api.nvim_create_autocmd('ColorScheme', {
    command = [[highlight! LirTransparentCursor gui=strikethrough blend=100]],
    group = lir_highlights,
})
vim.api.nvim_create_autocmd('ColorScheme', {
    command = [[highlight! def link LirFloatBorder TelescopeBorder]],
    group = lir_highlights,
})
