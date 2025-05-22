vim.filetype.add({
    extension = {
        cir = 'spice',
    },
})

-- change lsp hover border
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

-- change diagnostic signs
local signs = { Error = '󰅙', Warn = '', Hint = '󰛨', Info = '󰋼' }
for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.keymap.set(
    'n',
    '<leader>q',
    '<Cmd>lua vim.diagnostic.setloclist()<CR>',
    { noremap = true, silent = true, desc = 'Add diagnostics to the location list' }
)

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        -- Default mappings: :help lsp-defaults
        -- vim.keymap.set('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
        -- vim.keymap.set('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        -- vim.keymap.set('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        -- vim.keymap.set('n', '<leader>cr', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
        -- vim.keymap.set('n', '<leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)

        local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(
                mode,
                keys,
                func,
                { buffer = args.buf, noremap = true, silent = true, desc = 'lsp: ' .. desc }
            )
        end

        map('gD', vim.lsp.buf.declaration, 'Jumps to the declaration of the symbol under the cursor')
        map('gd', vim.lsp.buf.definition, 'Jumps to the definition of the symbol under the cursor')
        map('gy', vim.lsp.buf.type_definition, 'Jumps to the definition of the type of the symbol under the cursor')
        map('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Add the folder at path to the workspace folders')
        map('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Remove the folder at path from the workspace folders')
        map(
            '<leader>wl',
            '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
            'Print workspace folders'
        )
        map(
            '<leader>cf',
            '<Cmd>lua vim.lsp.buf.format({async = true})<CR>',
            'Formats a buffer using the attached (and optionally filtered) language server clients'
        )
        map('<leader>cd', vim.diagnostic.open_float, 'Show diagnostics in a floating window')
        -- default mappings (:help [d) won't open float
        map('[d', '<Cmd>lua vim.diagnostic.jump({count=-1, float=true})<CR>', 'Jump to the previous diagnostic')
        map(']d', '<Cmd>lua vim.diagnostic.jump({count=1, float=true})<CR>', 'Jump to the next diagnostic')
    end,
})

vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})
