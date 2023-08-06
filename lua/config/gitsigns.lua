require('gitsigns').setup({
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- navigation
        map('n', ']c', function()
            if vim.wo.diff then
                return ']c'
            end
            vim.schedule(function()
                gs.next_hunk()
            end)
            return '<Ignore>'
        end, { expr = true, desc = '[git] Goto next hunk' })

        map('n', '[c', function()
            if vim.wo.diff then
                return '[c'
            end
            vim.schedule(function()
                gs.prev_hunk()
            end)
            return '<Ignore>'
        end, { expr = true, desc = '[git] goto previous hunk' })

        -- actions
        map('n', '<leader>gr', gs.reset_hunk, { desc = '[git] reset hunk' })
        map('n', '<leader>gp', gs.preview_hunk, { desc = '[git] preview hunk' })
        map('n', '<leader>gb', function()
            gs.blame_line({ full = true })
        end, { desc = '[git] blame line' })
        map('n', '<leader>gB', gs.toggle_current_line_blame, { desc = '[git] toggle current line blame' })
        map('n', '<leader>gd', gs.diffthis, { desc = '[git] diffthis' })
        map('n', '<leader>gD', function()
            gs.diffthis('~')
        end, { desc = '[git] diffthis file' })

        -- text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end,
})
