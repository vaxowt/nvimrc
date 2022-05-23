vim.g.vsnip_snippet_dir = vim.fn.stdpath('config') .. '/vsnip'

vim.keymap.set(
    { 'i', 's' },
    '<C-j>',
    [[vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>']],
    { expr = true }
)

vim.keymap.set({ 'i', 's' }, '<C-k>', [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>']], { expr = true })

vim.keymap.set({ 'i', 's' }, '<Tab>', [[vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']], { expr = true })
vim.keymap.set({ 'i', 's' }, '<S-Tab>', [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']], { expr = true })
