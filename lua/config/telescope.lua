local telescope = require('telescope')
local actions = require('telescope.actions')
local action_layout = require('telescope.actions.layout')

telescope.setup({
    pickers = {
        find_files = {
            hidden = true,
        },
        buffers = {
            ignore_current_buffer = true,
            sort_mru = true,
        },
    },
    defaults = {
        file_ignore_patterns = { 'node_modules', '%.git' },
        -- used for grep_string and live_grep
        vimgrep_arguments = {
            'rg',
            '--follow',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--no-ignore',
            '--trim',
        },
        mappings = {
            i = {
                ['<esc>'] = actions.close,
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,
                ['<PageUp>'] = actions.results_scrolling_up,
                ['<PageDown>'] = actions.results_scrolling_down,
                ['<C-v>'] = actions.select_vertical,
                ['<C-s>'] = actions.select_horizontal,
                ['<C-t>'] = actions.select_tab,
                ['<C-/>'] = action_layout.toggle_preview,
                ['<C-n>'] = actions.cycle_history_next,
                ['<C-p>'] = actions.cycle_history_prev,
            },
        },
        sorting_strategy = 'ascending',
        scroll_strategy = 'cycle',
        layout_strategy = 'flex',
        results_title = '',
        color_devicons = true,
        layout_config = {
            prompt_position = 'top',
        },
    },
})

vim.keymap.set(
    'n',
    '<leader>fs',
    "<Cmd>lua require('telescope.builtin').builtin()<CR>",
    { noremap = true, silent = true }
)
vim.keymap.set(
    'n',
    '<leader>fG',
    "<Cmd>lua require('telescope.builtin').grep_string()<CR>",
    { noremap = true, silent = true }
)
vim.keymap.set(
    'n',
    '<leader>fg',
    "<Cmd>lua require('telescope.builtin').live_grep()<CR>",
    { noremap = true, silent = true }
)
vim.keymap.set(
    'n',
    '<leader>fb',
    "<Cmd>lua require('telescope.builtin').buffers()<CR>",
    { noremap = true, silent = true }
)
vim.keymap.set(
    'n',
    '<leader>fh',
    "<Cmd>lua require('telescope.builtin').help_tags()<CR>",
    { noremap = true, silent = true }
)
vim.keymap.set(
    'n',
    '<leader>fH',
    "<Cmd>lua require('telescope.builtin').man_pages()<CR>",
    { noremap = true, silent = true }
)
vim.keymap.set(
    'n',
    '<leader>ff',
    "<Cmd>lua require('telescope.builtin').find_files()<CR>",
    { noremap = true, silent = true }
)
vim.keymap.set(
    'n',
    '<leader>fF',
    "<Cmd>lua require('telescope.builtin').git_files()<CR>",
    { noremap = true, silent = true }
)
vim.keymap.set(
    'n',
    '<leader>fr',
    "<Cmd>lua require('telescope.builtin').resume()<CR>",
    { noremap = true, silent = true }
)
vim.keymap.set(
    'n',
    '<leader>fc',
    "<Cmd>lua require('telescope.builtin').commands()<CR>",
    { noremap = true, silent = true }
)
vim.keymap.set(
    'n',
    '<leader>fm',
    "<Cmd>lua require('telescope.builtin').oldfiles()<CR>",
    { noremap = true, silent = true }
)
vim.keymap.set(
    'n',
    '<leader>fM',
    "<Cmd>lua require('telescope.builtin').keymaps()<CR>",
    { noremap = true, silent = true }
)
vim.keymap.set(
    'n',
    '<leader>f/',
    "<Cmd>lua require('telescope.builtin').search_history()<CR>",
    { noremap = true, silent = true }
)
