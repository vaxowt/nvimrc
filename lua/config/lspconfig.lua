local border = {
    { '┌', 'NormalFloat' },
    { '─', 'NormalFloat' },
    { '┐', 'NormalFloat' },
    { '│', 'NormalFloat' },
    { '┘', 'NormalFloat' },
    { '─', 'NormalFloat' },
    { '└', 'NormalFloat' },
    { '│', 'NormalFloat' },
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local signs = { Error = '', Warn = '', Hint = 'ﯦ', Info = '' }
for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.keymap.set(
    'n',
    '<leader>cd',
    '<Cmd>lua vim.diagnostic.open_float()<CR>',
    { noremap = true, silent = true, desc = 'Open diagnostic float window' }
)
vim.keymap.set(
    'n',
    '[d',
    '<Cmd>lua vim.diagnostic.goto_prev()<CR>',
    { noremap = true, silent = true, desc = 'Goto previous diagnostic' }
)
vim.keymap.set(
    'n',
    ']d',
    '<Cmd>lua vim.diagnostic.goto_next()<CR>',
    { noremap = true, silent = true, desc = 'Goto next diagnostic' }
)
vim.keymap.set(
    'n',
    '<leader>q',
    '<Cmd>lua vim.diagnostic.setloclist()<CR>',
    { noremap = true, silent = true, desc = 'Add diagnostics to the location list' }
)

local on_attach = function(client, bufnr)
    -- vim-illuminate
    require('illuminate').on_attach(client)

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.keymap.set('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.keymap.set('n', 'gy', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.keymap.set('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.keymap.set('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.keymap.set('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.keymap.set('n', '<leader>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.keymap.set('n', '<leader>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.keymap.set('n', '<leader>wl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.keymap.set('n', '<leader>cr', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.keymap.set('n', '<leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.keymap.set('n', '<leader>cf', '<Cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local servers = { 'pyright', 'clangd', 'bashls', 'texlab', 'yamlls', 'jsonls' }

for _, server in pairs(servers) do
    require('lspconfig')[server].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

require('lspconfig').lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}
