local null_ls = require("null-ls")

-- code action sources
local code_actions = null_ls.builtins.code_actions

-- diagnostic sources
local diagnostics = null_ls.builtins.diagnostics

-- formatting sources
local formatting = null_ls.builtins.formatting

-- hover sources
local hover = null_ls.builtins.hover

-- completion sources
local completion = null_ls.builtins.completion

null_ls.setup({
    sources = {
        -- general
        -- completion.spell,
        -- lua
        formatting.stylua,
        -- python
        formatting.yapf,
        formatting.isort,
        -- diagnostics.pydocstyle,
        -- diagnostics.pycodestyle,
        -- shell
        hover.printenv,
    }
})
