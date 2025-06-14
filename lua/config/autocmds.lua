local api = vim.api

-- jump to last position when reading a file
api.nvim_create_autocmd(
    'BufReadPost',
    { command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
)

-- show cursor line only in active window
local grp_cursorline = api.nvim_create_augroup('grp_cursorline', { clear = true })
api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
    pattern = '*',
    command = 'set cursorline',
    group = grp_cursorline,
})
api.nvim_create_autocmd(
    { 'InsertEnter', 'WinLeave' },
    { pattern = '*', command = 'set nocursorline', group = grp_cursorline }
)

-- -- override highlights
-- -- ref: https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f
-- local floatborder_highlights = api.nvim_create_augroup("floatborder_highlights", { clear = true })
-- api.nvim_create_autocmd("ColorScheme", {
--     command = [[highlight! def link FloatBorder Grey]],
--     group = floatborder_highlights,
-- })

-- -- auto-source config
-- local grp_auto_source = api.nvim_create_augroup("grp_auto_source", {clear=true})
-- api.nvim_create_autocmd("BufWritePost", {
--     pattern = vim.env.MYVIMRC,
--     nested = true,
--     command = 'source $MYVIMRC',
--     group = grp_auto_source,
-- })
