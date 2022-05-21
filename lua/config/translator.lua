vim.g.translator_history_enable = true
vim.g.translator_default_engines = { "haici", "youdao" }

vim.keymap.set("n", "<leader>t", "<Plug>TranslateW")

vim.keymap.set("v", "<leader>t", "<Plug>TranslateWV")

vim.cmd([[
highlight def link TranslatorBorder TelescopeBorder
]])
