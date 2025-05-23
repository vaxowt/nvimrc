require('nvim-tree').setup({
    -- use lir.nvim
    hijack_netrw = false,

    -- auto switch cwd, projects.nvim
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
        enable = true,
        update_root = true,
    },

    renderer = {
        -- show hidden files count
        hidden_display = 'all',
    },
    filters = {
        -- hide dotfiles by default
        dotfiles = true,
    },
    on_attach = function(bufnr)
        local api = require('nvim-tree.api')
        local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        api.config.mappings.default_on_attach(bufnr)

        vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
        vim.keymap.del('n', '<C-k>', { buffer = bufnr })
        vim.keymap.set('n', 'K', api.node.show_info_popup, opts('Info'))
        vim.keymap.set('n', ']d', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
        vim.keymap.set('n', '[d', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
        vim.keymap.set('n', '}', api.node.navigate.sibling.last, opts('Last Sibling'))
        vim.keymap.set('n', '{', api.node.navigate.sibling.first, opts('First Sibling'))
        vim.keymap.set('n', 'N', api.fs.create, opts('Create File Or Directory'))
        vim.keymap.set('n', 'R', api.fs.rename, opts('Rename'))
        vim.keymap.set('n', '<C-r>', api.tree.reload, opts('Rename: Omit Filename'))
        vim.keymap.del('n', 'H', { buffer = bufnr })
        vim.keymap.set('n', '.', api.tree.toggle_hidden_filter, opts('Toggle Filter: Dotfiles'))
        vim.keymap.set('n', '!', api.node.run.cmd, opts('Run Command'))
    end,
})
