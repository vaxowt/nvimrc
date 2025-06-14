vim.filetype.add({
    extension = {
        cir = 'spice',
    },
})

-- local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
-- function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
--     opts = opts or {}
--     opts.border = opts.border or 'rounded'
--     return orig_util_open_floating_preview(contents, syntax, opts, ...)
-- end

-- change diagnostic signs
local signs = { Error = '󰅙', Warn = '', Hint = '󰛨', Info = '󰋼' }
for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local preferred_formatters = {
    -- python = { 'ruff' },
}

local function get_none_ls_available_formatters(bufnr)
    local filetype = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
    local fmts = {}
    for _, v in
        ipairs(require('null-ls.sources').get_available(filetype, require('null-ls.methods').internal.FORMATTING))
    do
        fmts[#fmts + 1] = v.name
    end
    return fmts
end

local function is_none_ls_formatting_enabled(bufnr)
    return #get_none_ls_available_formatters(bufnr) > 0
end

-- Formatter selection order:
--  1. Preferred formatter, if defined. Only the first available formatter is used.
--  2. Null-ls, if it supports formatting.
--  3. Others. All the clients supportting formatting are used.
local lsp_formatting = function(bufnr)
    local file_type = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
    local preferred = preferred_formatters[file_type]

    local clients = vim.lsp.get_clients()
    local clients_map = {}
    for _, client in ipairs(clients) do
        clients_map[client.name] = client
    end

    local match = nil
    if preferred ~= nil then
        for _, formatter in ipairs(preferred) do
            if clients_map[formatter] ~= nil then
                match = formatter
                break
            end
        end
    end

    vim.lsp.buf.format({
        filter = function(client)
            local ret = true
            if match ~= nil then
                ret = client.name == match
            elseif is_none_ls_formatting_enabled(bufnr) then
                ret = client.name == 'null-ls'
            end
            if ret then
                local msg = client.name
                if client.name == 'null-ls' then
                    msg = string.format('%s (%s)', msg, table.concat(get_none_ls_available_formatters(bufnr), ', '))
                end
                print('Format with: ' .. msg)
            end
            return ret
        end,
        bufnr = bufnr,
        async = true,
    })
end

vim.keymap.set(
    'n',
    '<leader>dq',
    vim.diagnostic.setloclist,
    { noremap = true, silent = true, desc = 'Add diagnostics to the location list' }
)

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        -- Default mappings (:help lsp-defaults):
        -- * "grn" is mapped in Normal mode to vim.lsp.buf.rename()
        -- * "gra" is mapped in Normal and Visual mode to vim.lsp.buf.code_action()
        -- * "grr" is mapped in Normal mode to vim.lsp.buf.references()
        -- * "gri" is mapped in Normal mode to vim.lsp.buf.implementation()
        -- * "gO" is mapped in Normal mode to vim.lsp.buf.document_symbol()
        -- * CTRL-S is mapped in Insert mode to vim.lsp.buf.signature_help()

        local bufnr = args.buf

        -- Ensure null-ls.nvim does not interfere with formatexpr behavior
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client ~= nil then
            if client.server_capabilities.documentFormattingProvider then
                if client.name == 'null-ls' and is_none_ls_formatting_enabled(bufnr) or client.name ~= 'null-ls' then
                    vim.bo[bufnr].formatexpr = 'v:lua.vim.lsp.formatexpr()'
                else
                    vim.bo[bufnr].formatexpr = nil
                end
            end
        end

        local function map(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = bufnr, noremap = true, silent = true, desc = 'lsp: ' .. desc })
        end

        -- stylua: ignore start
        -- map('gD', vim.lsp.buf.declaration, 'Jumps to the declaration')
        -- map('gd', vim.lsp.buf.definition, 'Jumps to the definition')
        -- map('gy', vim.lsp.buf.type_definition, 'Jumps to the definition of the type')
        map('<leader>la', vim.lsp.buf.add_workspace_folder, 'Add the folder at path to the workspace folders')
        map('<leader>lr', vim.lsp.buf.remove_workspace_folder, 'Remove the folder at path from the workspace folders')
        map('<leader>lw', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, 'Print workspace folders')
        map('<leader>lf', function() lsp_formatting(bufnr) end, 'Formats buffer', { 'n', 'v' })
        map('<leader>ld', vim.diagnostic.open_float, 'Show diagnostics in a floating window')
        -- default mappings (:help [d) won't open float
        map('[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, 'Jump to the previous diagnostic')
        map(']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, 'Jump to the next diagnostic')
        -- stylua: ignore end
    end,
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
vim.lsp.config('lua_ls', {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
                path ~= vim.fn.stdpath('config')
                and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
            then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using (most
                -- likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Tell the language server how to find Lua modules same way as Neovim
                -- (see `:h lua-module-load`)
                path = {
                    'lua/?.lua',
                    'lua/?/init.lua',
                },
            },
            -- diagnostics = {
            --     -- Get the language server to recognize the `vim` global
            --     globals = { 'vim', 'Snacks' },
            -- },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                -- library = {
                --     vim.env.VIMRUNTIME,
                --     -- Depending on the usage, you might want to add additional paths
                --     -- here.
                --     -- '${3rd}/luv/library'
                --     -- '${3rd}/busted/library'
                -- },
                -- Or pull in all of 'runtimepath'.
                -- NOTE: this is a lot slower and will cause issues when working on
                -- your own configuration.
                -- See https://github.com/neovim/nvim-lspconfig/issues/3189
                library = vim.api.nvim_get_runtime_file('', true),
            },
        })
    end,
    settings = {
        Lua = {},
    },
})
