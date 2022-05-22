require('lightspeed').setup({
    ignore_case = true,
})

-- use `;` and `,` to repeat the last Lightspeed motion (s/x or f/t):
vim.g.lightspeed_last_motion = ''

local lightspeed_last_motion = vim.api.nvim_create_augroup('lightspeed_last_motion', { clear = true })
vim.api.nvim_create_autocmd('User', {
    pattern = 'LightspeedSxEnter',
    command = [[let g:lightspeed_last_motion = 'sx']],
    group = lightspeed_last_motion,
})
vim.api.nvim_create_autocmd('User', {
    pattern = 'LightspeedFtEnter',
    command = [[let g:lightspeed_last_motion = 'ft']],
    group = lightspeed_last_motion,
})

vim.keymap.set(
    'n',
    ';',
    [[g:lightspeed_last_motion == 'sx' ? "<Plug>Lightspeed_;_sx" : "<Plug>Lightspeed_;_ft"]],
    { expr = true }
)
vim.keymap.set(
    'n',
    ',',
    [[g:lightspeed_last_motion == 'sx' ? "<Plug>Lightspeed_,_sx" : "<Plug>Lightspeed_,_ft"]],
    { expr = true }
)
