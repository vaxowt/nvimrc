-- move cursor one character left/right in insert mode
Has_cursor_move_map = false
local function set_mappings_for_curosr_move()
    if not Has_cursor_move_map and not vim.o.insertmode then
        vim.keymap.set('i', '<C-h>', '<Left>', { noremap = true })
        vim.keymap.set('i', '<C-l>', '<Right>', { noremap = true })
        Has_cursor_move_map = true
    elseif Has_cursor_move_map then
        vim.keymap.del('i', '<C-h>')
        vim.keymap.del('i', '<C-l>')
        Has_cursor_move_map = false
    end
end

set_mappings_for_curosr_move()

local grp_curosr_move_map = vim.api.nvim_create_augroup('grp_curosr_move_map', { clear = true })
vim.api.nvim_create_autocmd('OptionSet', {
    pattern = 'insertmode',
    callback = set_mappings_for_curosr_move,
    group = grp_curosr_move_map,
})

-- <Space> is mapped as leader
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- move inside wrapped line
vim.keymap.set({ 'n', 'v' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set({ 'n', 'v' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- close tab
vim.keymap.set('n', '<C-w>c', '<CMD>tabclose<CR>', { noremap = true, silent = true })

-- terminal keymaps
local function set_terminal_keymaps()
    local function opts(desc)
        return { buffer = 0, desc = desc }
    end
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts('Move to the left window'))
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts('Move to the below window'))
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts('Move to the up window'))
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts('Move to the right window'))
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts('Send <C-w> like in normal mode'))

    local exclude_filetypes = {
        yazi = false,
    }

    local filetype = vim.api.nvim_get_option_value('filetype', { buf = 0 })
    if exclude_filetypes[filetype] == nil then
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts('Switch to normal mode'))
        vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts('Switch to normal mode'))
    end
end

vim.api.nvim_create_autocmd('TermOpen', {
    pattern = 'term://*',
    callback = set_terminal_keymaps,
})
