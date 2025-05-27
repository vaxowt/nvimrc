local function map(keys, func, desc, mode)
    mode = mode or 'n'
    vim.keymap.set(mode, keys, func, { noremap = true, silent = true, desc = 'Telescope: ' .. desc })
end

local function config_telescope()
    local telescope = require('telescope')
    local builtin = require('telescope.builtin')
    local actions = require('telescope.actions')
    local action_layout = require('telescope.actions.layout')

    telescope.setup({
        pickers = {
            find_files = {
                hidden = true,
            },
            buffers = {
                ignore_current_buffer = true,
                sort_mru = true,
            },
            builtin = {
                include_extensions = true,
            },
        },
        extensions = {
            fzf = {},
        },
        defaults = {
            file_ignore_patterns = { 'node_modules', '%.git', '__pycache__' },
            -- used for grep_string and live_grep
            vimgrep_arguments = {
                'rg',
                '--follow',
                '--color=never',
                '--no-heading',
                '--with-filename',
                '--line-number',
                '--column',
                '--smart-case',
                '--no-ignore',
                '--trim',
            },
            mappings = {
                i = {
                    ['<esc>'] = actions.close,
                    ['<C-j>'] = actions.move_selection_next,
                    ['<C-k>'] = actions.move_selection_previous,
                    ['<PageUp>'] = actions.results_scrolling_up,
                    ['<PageDown>'] = actions.results_scrolling_down,
                    ['<C-\\>'] = action_layout.toggle_preview,
                    ['<C-n>'] = actions.cycle_history_next,
                    ['<C-p>'] = actions.cycle_history_prev,
                },
            },
            sorting_strategy = 'ascending',
            scroll_strategy = 'cycle',
            layout_strategy = 'flex',
            results_title = false,
            dynamic_preview_title = true,
            color_devicons = true,
            layout_config = {
                prompt_position = 'top',
            },
        },
    })

    require('telescope').load_extension('fzf')
    require('telescope').load_extension('repo')
    require('telescope').load_extension('jsonfly')
    require('telescope').load_extension('helpgrep')
    require('telescope').load_extension('hierarchy')

    map('<leader>fs', builtin.builtin, 'builtin')
    map('<leader>fG', builtin.grep_string, 'grep_string')
    map('<leader>fg', builtin.live_grep, 'live_grep')
    map('<leader>fb', builtin.buffers, 'buffers')
    map('<leader>fh', builtin.help_tags, 'help_tags')
    map('<leader>fH', builtin.man_pages, 'man_pages')
    map('<leader>ff', builtin.find_files, 'find_files')
    map('<leader>fF', builtin.git_files, 'git_files')
    map('<leader>fr', builtin.resume, 'resume')
    map('<leader>fc', builtin.commands, 'commands')
    map('<leader>fm', builtin.oldfiles, 'oldfiles')
    map('<leader>fM', builtin.keymaps, 'man_pages')
    map('<leader>f/', builtin.search_history, 'search_history')
    map('<leader>fd', builtin.diagnostics, 'diagnostics')
end

return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            { 'nvim-telescope/telescope-symbols.nvim' },
            -- Jump into the repositories (git, mercurial…) of your filesystem with telescope.nvim, without any setup
            { 'cljoly/telescope-repo.nvim' },
            -- Fly through your JSON / XML / YAML files with ease. Search blazingly fast for keys via Telescope.
            { 'Myzel394/jsonfly.nvim' },
            -- Telescope extension that uses Telescope builtins (live_grep or grep_string) to grep through help files
            { 'catgoose/telescope-helpgrep.nvim' },
            -- A Telescope.nvim extension for viewing & navigating the call hierarchy
            { 'jmacadie/telescope-hierarchy.nvim' },
        },
        config = config_telescope,
    },

    -- Clipboard manager neovim plugin with telescope integration
    {
        'AckslD/nvim-neoclip.lua',
        dependencies = 'nvim-telescope/telescope.nvim',
        lazy = false,
        opts = {},
        config = function(_, opts)
            require('neoclip').setup(opts)
            require('telescope').load_extension('neoclip')
        end,
        keys = {
            { '<leader>fy', '<Cmd>Telescope neoclip<CR>', desc = 'neoclip' },
        },
    },

    -- The superior project management solution for neovim.
    {
        'ahmedkhalf/project.nvim',
        dependencies = 'nvim-telescope/telescope.nvim',
        opts = {
            show_hidden = true,
            -- FIX: LSP detection method not working. https://github.com/ahmedkhalf/project.nvim/issues/169
            detection_methods = { 'pattern', 'lsp' },
        },
        config = function(_, opts)
            require('project_nvim').setup(opts)

            require('telescope').load_extension('projects')

            map('<leader>fp', require('telescope').extensions.projects.projects, 'projects')
        end,
    },
}
