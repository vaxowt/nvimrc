vim.o.completeopt = 'menu,menuone,noselect'

local cmp = require('cmp')

local kind_icons = {
    Text = '',
    Method = '',
    Function = '',
    Constructor = '',
    Field = '',
    Variable = '',
    Class = 'ﴯ',
    Interface = '',
    Module = '',
    Property = '',
    Unit = '',
    Value = '',
    Enum = '',
    Keyword = '',
    Snippet = '',
    Color = '',
    File = '',
    Reference = '',
    Folder = '',
    EnumMember = '',
    Constant = '',
    Struct = '',
    Event = '',
    Operator = '',
    TypeParameter = '',
}

cmp.setup({
    snippet = {
        expand = function(args)
            require('snippy').expand_snippet(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    }),
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = kind_icons[vim_item.kind] or ''
            vim_item.menu = ({
                buffer = '[B]',
                path = '[P]',
                snippy = '[S]',
                nvim_lsp = '[LSP]',
                calc = '[calc]',
                dictionary = '[D]',
                tmux = '[tmux]',
            })[entry.source.name]
            return vim_item
        end,
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_document_symbol' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'snippy' },
    }, {
        {
            name = 'buffer',
            option = {
                get_bufnrs = function()
                    local bufs = {}
                    for _, win in ipairs(vim.api.nvim_list_wins()) do
                        bufs[vim.api.nvim_win_get_buf(win)] = true
                    end
                    return vim.tbl_keys(bufs)
                end,
            },
        },
        { name = 'path' },
        { name = 'calc' },
        { name = 'tmux' },
        { name = 'greek' },
        { name = 'emoji' },
        { name = 'dictionary', keyword_length = 2 },
    }),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' },
    },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' },
    }, {
        { name = 'cmdline', keyword_length = 2, },
    }),
})

require('cmp_dictionary').setup({
    dic = {
        ['*'] = { '/usr/share/dict/words' },
    },
    first_case_insensitive = true,
    async = true,
})
