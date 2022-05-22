vim.g.translator_history_enable = true
vim.g.translator_default_engines = { "haici", "youdao" }

vim.keymap.set("n", "<leader>t", "<Plug>TranslateW")

vim.keymap.set("v", "<leader>t", "<Plug>TranslateWV")

local grp_translator_colors = vim.api.nvim_create_augroup("grp_translator_colors", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = '*',
    command = [[highlight! def link TranslatorBorder Normal]],
    group = grp_translator_colors,
})
