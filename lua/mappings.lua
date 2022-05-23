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
