local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

return {

    {
        'dcampos/nvim-snippy',
        event = 'InsertEnter',
        opts = {
            mappings = {
                is = {
                    ['<C-j>'] = 'expand_or_advance',
                    ['<C-k>'] = 'previous',
                },
            },
        },
    },

    { 'honza/vim-snippets' },

    -- A completion plugin for neovim coded in Lua
    {
        'hrsh7th/nvim-cmp',
        event = { 'InsertEnter', 'CmdlineEnter' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lsp-signature-help' },
            { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
            { 'dcampos/cmp-snippy' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },
            { 'hrsh7th/cmp-calc' },
            { 'hrsh7th/cmp-emoji' },
            { 'uga-rosa/cmp-dictionary' },
            { 'andersevenrud/cmp-tmux' },
            { 'max397574/cmp-greek' },
            { 'wxxxcxx/cmp-browser-source' },
            { 'Exafunction/windsurf.nvim' },
        },
        config = function()
            vim.o.completeopt = 'menu,menuone,noselect'

            local cmp = require('cmp')

            local kind_icons = {
                Text = '󰦨',
                Method = '',
                Function = '󰊕',
                Constructor = '󰆧',
                Field = '',
                Variable = '',
                Class = '',
                Interface = '',
                Module = '',
                Property = '',
                Unit = '',
                Value = '󰎠',
                Enum = '',
                Keyword = '',
                Snippet = '',
                Color = '󰏘',
                File = '󰈙',
                Reference = '',
                Folder = '󰉋',
                EnumMember = '',
                Constant = '󰐀',
                Struct = '󱃖',
                Event = '',
                Operator = '',
                TypeParameter = '',
                Codeium = '',
            }

            local menu_icons = {
                calc = '󰃬',
                greek = '󱌮',
                emoji = '󰱫',
            }

            require('cmp-browser-source').start_server()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('snippy').expand_snippet(args.body)
                    end,
                },
                window = {
                    -- completion = cmp.config.window.bordered(),
                    -- documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    -- close cmp menu with <esc>
                    ['<Esc>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.abort()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),

                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if #cmp.get_entries() == 1 then
                                -- Confirm candidate on TAB immediately when there's only one completion entry
                                cmp.confirm({ select = true })
                            else
                                cmp.select_next_item()
                            end
                        elseif require('snippy').can_expand_or_advance() then
                            require('snippy').expand_or_advance()
                        elseif has_words_before() then
                            cmp.complete()
                            if #cmp.get_entries() == 1 then
                                -- Confirm candidate on TAB immediately when there's only one completion entry
                                cmp.confirm({ select = true })
                            end
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),

                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif require('snippy').can_jump(-1) then
                            require('snippy').previous()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),

                    -- safely select entries with <CR>
                    ['<CR>'] = cmp.mapping({
                        i = function(fallback)
                            if cmp.visible() and cmp.get_active_entry() then
                                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                            else
                                fallback()
                            end
                        end,
                        s = cmp.mapping.confirm({ select = true }),
                    }),
                }),
                formatting = {
                    format = function(entry, vim_item)
                        if vim_item.kind == 'Text' then
                            vim_item.kind = menu_icons[entry.source.name] or kind_icons[vim_item.kind]
                        else
                            vim_item.kind = kind_icons[vim_item.kind] or ''
                        end
                        vim_item.menu = ({
                            buffer = '[B]',
                            path = '[P]',
                            snippy = '[S]',
                            nvim_lsp = '[LSP]',
                            dictionary = '[D]',
                            tmux = '[tmux]',
                            codeium = '[AI]',
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
                    { name = 'browser' },
                    { name = 'codeium' },
                }),
            })

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
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
                    { name = 'cmdline' },
                }),
                matching = { disallow_symbol_nonprefix_matching = false },
            })

            require('cmp_dictionary').setup({
                dic = {
                    ['*'] = { '/usr/share/dict/words' },
                },
                first_case_insensitive = true,
                async = true,
            })
        end,
    },

    {
        'Exafunction/windsurf.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        cmd = 'Codeium',
        event = 'InsertEnter',
        main = 'codeium',
        opts = {
            virtual_text = {
                enable = true,
            },
        },
    },
}
