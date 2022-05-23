vim.g.symbols_outline = {
    auto_preview = false,
    -- show_symbol_details = true,
}

vim.keymap.set('n', '<leader>]', '<Cmd>SymbolsOutline<CR>', { noremap = true, silent = true })

local symbols_outline_custom = vim.api.nvim_create_augroup('symbols_outline_custom', { clear = true })
vim.api.nvim_create_autocmd('ColorScheme', {
    command = [[highlight! def link FocusedSymbol PreProc]],
    group = symbols_outline_custom,
})
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'Outline',
    command = [[set nowrap]],
    group = symbols_outline_custom,
})
