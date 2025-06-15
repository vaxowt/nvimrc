return {

    {
        'folke/snacks.nvim',
        opts = {
            ---@class snacks.picker.Config
            picker = {
                layout = {
                    preset = function()
                        return vim.fn.winheight(0) * 2 < vim.fn.winwidth(0) and 'default' or 'vertical'
                    end,
                },
            },
        },
        keys = {
        -- stylua: ignore start
        -- Top Pickers
        { "<leader><space>", function() Snacks.picker.resume() end, desc = "picker: resume" },
        { "<leader>.",       function() Snacks.picker.buffers({ current = false }) end, desc = "picker: buffers" },
        { "<leader>/",       function() Snacks.picker.grep() end, desc = "picker: grep" },
        { "<leader>:",       function() Snacks.picker.command_history() end, desc = "picker: command history" },
        { "<leader>n",       function() Snacks.picker.notifications() end, desc = "picker: notification history" },
        -- find
        { "<leader>fb",      function() Snacks.picker.buffers({ current = false }) end, desc = "picker: buffers" },
        { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "picker: find config file" },
        { "<leader>ff",      function() Snacks.picker.files() end, desc = "picker: find files" },
        { "<leader>fg",      function() Snacks.picker.git_files() end, desc = "picker: find git files" },
        { "<leader>fp",      function() Snacks.picker.projects() end, desc = "picker: projects" },
        { "<leader>fr",      function() Snacks.picker.recent() end, desc = "picker: recent" },
        -- git
        { "<leader>gB",      function() Snacks.picker.git_branches() end, desc = "git: branches" },
        { "<leader>gl",      function() Snacks.picker.git_log() end, desc = "git: log" },
        { "<leader>gL",      function() Snacks.picker.git_log_line() end, desc = "git: log line" },
        { "<leader>gs",      function() Snacks.picker.git_status() end, desc = "git: status" },
        { "<leader>gS",      function() Snacks.picker.git_stash() end, desc = "git: stash" },
        -- { "<leader>gd",     function() Snacks.picker.git_diff() end, desc = "git: diff (hunks)" },
        { "<leader>gf",      function() Snacks.picker.git_log_file() end, desc = "git: log file" },
        -- Grep
        { "<leader>sb",      function() Snacks.picker.lines() end, desc = "picker: buffer lines" },
        { "<leader>sB",      function() Snacks.picker.grep_buffers() end, desc = "picker: grep open buffers" },
        { "<leader>sg",      function() Snacks.picker.grep() end, desc = "picker: grep" },
        { "<leader>sw",      function() Snacks.picker.grep_word() end, desc = "picker: visual selection or word", mode = { "n", "x" } },
        -- search
        { '<leader>s"',      function() Snacks.picker.registers() end, desc = "picker: registers" },
        { '<leader>s/',      function() Snacks.picker.search_history() end, desc = "picker: search history" },
        { "<leader>sa",      function() Snacks.picker.autocmds() end, desc = "picker: autocmds" },
        { "<leader>sc",      function() Snacks.picker.commands() end, desc = "picker: commands" },
        { "<leader>sd",      function() Snacks.picker.diagnostics_buffer() end, desc = "picker: buffer diagnostics" },
        { "<leader>sD",      function() Snacks.picker.diagnostics() end, desc = "picker: diagnostics" },
        { "<leader>sh",      function() Snacks.picker.help() end, desc = "picker: help pages" },
        { "<leader>sH",      function() Snacks.picker.highlights() end, desc = "picker: highlights" },
        { "<leader>si",      function() Snacks.picker.icons() end, desc = "picker: icons" },
        { "<leader>sj",      function() Snacks.picker.jumps() end, desc = "picker: jumps" },
        { "<leader>sk",      function() Snacks.picker.keymaps() end, desc = "picker: keymaps" },
        { "<leader>sl",      function() Snacks.picker.loclist() end, desc = "picker: location list" },
        { "<leader>sm",      function() Snacks.picker.marks() end, desc = "picker: marks" },
        { "<leader>sM",      function() Snacks.picker.man() end, desc = "picker: man pages" },
        { "<leader>sp",      function() Snacks.picker.lazy() end, desc = "picker: search for plugin spec" },
        { "<leader>sq",      function() Snacks.picker.qflist() end, desc = "picker: quickfix list" },
        { "<leader>ss",      function() Snacks.picker.smart() end, desc = "picker: smart find files" },
        { '<leader>sS',      function() Snacks.picker.pickers() end, desc = "picker: pickers" },
        { "<leader>su",      function() Snacks.picker.undo() end, desc = "picker: undo history" },
        { "<leader>uC",      function() Snacks.picker.colorschemes() end, desc = "picker: colorschemes" },
        -- LSP
        { "gd",              function() Snacks.picker.lsp_definitions() end, desc = "lsp: goto definition" },
        { "gD",              function() Snacks.picker.lsp_declarations() end, desc = "lsp: goto declaration" },
        { "gr",              function() Snacks.picker.lsp_references() end, nowait = true, desc = "lsp: references" },
        { "gI",              function() Snacks.picker.lsp_implementations() end, desc = "lsp: goto implementation" },
        { "gy",              function() Snacks.picker.lsp_type_definitions() end, desc = "lsp: goto type definition" },
        { "<leader>ls",      function() Snacks.picker.lsp_symbols() end, desc = "lsp: symbols" },
        { "<leader>lS",      function() Snacks.picker.lsp_workspace_symbols() end, desc = "lsp: workspace symbols" },
            -- stylua: ignore stop
        },
    },

    -- Clipboard manager neovim plugin with telescope integration
    -- TODO: migrate to snacks.nvim
    {
        'AckslD/nvim-neoclip.lua',
        dependencies = 'nvim-telescope/telescope.nvim',
        opts = {},
        cmds = { 'Telescope' },
        config = function(_, opts)
            require('neoclip').setup(opts)
            require('telescope').load_extension('neoclip')
        end,
        keys = {
            { '<leader>sy', '<Cmd>Telescope neoclip<CR>', desc = 'neoclip' },
        },
    },
}
