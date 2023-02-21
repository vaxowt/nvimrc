local function get_config(name)
    return function()
        require(string.format('config/%s', name))
    end
end

return {
    'luukvbaal/stabilize.nvim',

    -- Nvim Treesitter configurations and abstraction layer
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',
        config = get_config('treesitter'),
    },

    -- Portable package manager for Neovim that runs everywhere Neovim runs.
    -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
    {
        'williamboman/mason.nvim',
        config = get_config('mason'),
    },
    {
        'williamboman/mason-lspconfig.nvim',
        config = get_config('mason-lspconfig'),
    },

    -- Quickstart configurations for the Nvim LSP client
    {
        'neovim/nvim-lspconfig',
        config = get_config('lspconfig'),
        dependencies = { 'mason-lspconfig.nvim', 'vim-illuminate' },
    },

    -- A completion plugin for neovim coded in Lua
    {
        'hrsh7th/nvim-cmp',
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
        },
        config = get_config('cmp'),
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons' },
        config = get_config('lualine'),
    },

    {
        'dcampos/nvim-snippy',
        config = get_config('snippy'),
    },

    { 'honza/vim-snippets' },

    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            { 'nvim-telescope/telescope-symbols.nvim' },
            { 'cljoly/telescope-repo.nvim' },
        },
        config = get_config('telescope'),
    },

    {
        'mfussenegger/nvim-dap',
        module = true,
        config = get_config('dap'),
    },

    {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'mfussenegger/nvim-dap' },
        config = get_config('dapui'),
    },

    { 'dstein64/vim-startuptime', cmd = 'StartupTime' },

    {
        'ahmedkhalf/project.nvim',
        dependencies = 'nvim-telescope/telescope.nvim',
        config = get_config('project'),
    },

    {
        'jedrzejboczar/possession.nvim',
        dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
        config = get_config('possession'),
    },

    {
        'EdenEast/nightfox.nvim',
        lazy = true,
        config = get_config('nightfox'),
    },
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        lazy = true,
    },
    {
        'marko-cerovac/material.nvim',
        lazy = true,
    },
    {
        'projekt0n/github-nvim-theme',
        lazy = true,
    },
    { 'ful1e5/onedark.nvim' },
    -- Gruvbox with Material Palette
    {
        'sainnhe/gruvbox-material',
        lazy = true,
        -- load config first
        config = get_config('gruvbox-material'),
    },
    -- Comfortable & Pleasant Color Scheme for Vim
    {
        'sainnhe/everforest',
        lazy = false,
        config = get_config('everforest'),
    },
    {
        'sainnhe/edge',
        lazy = false,
        config = get_config('edge'),
    },
    -- An arctic, north-bluish clean and elegant Vim theme
    {
        'shaunsingh/nord.nvim',
        lazy = false,
    },

    {
        'windwp/nvim-autopairs',
        config = get_config('autopairs'),
    },

    {
        'numToStr/Comment.nvim',
        config = get_config('comment'),
    },

    {
        'tamago324/lir.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'kyazdani42/nvim-web-devicons',
        },
        config = get_config('lir'),
    },

    -- Auto-toggle hlsearch, and show number of matches
    { 'romainl/vim-cool' },

    -- A (Neo)vim plugin for formatting code.
    {
        'sbdchd/neoformat',
        cmd = 'Neoformat',
        keys = { { '<leader>F', '<Cmd>Neoformat<CR>', desc = 'Neoformat' } },
        config = get_config('neoformat'),
    },

    {
        'machakann/vim-sandwich',
        config = get_config('sandwich'),
    },

    --  A Vim alignment plugin
    {
        'junegunn/vim-easy-align',
        config = get_config('easy-align'),
    },

    { 'tpope/vim-repeat' },

    {
        'ggandor/leap.nvim',
        config = get_config('leap'),
    },

    -- FIX: neovim startup screen not showing
    {
        'folke/todo-comments.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        config = true,
    },

    {
        'simrat39/symbols-outline.nvim',
        cmd = 'SymbolsOutline',
        keys = { { '<leader>]', '<Cmd>SymbolsOutline<CR>' } },
        config = get_config('symbols-outline'),
    },

    {
        'gorbit99/codewindow.nvim',
        cmd = 'Minimap',
        config = get_config('codewindow'),
    },

    {
        'akinsho/bufferline.nvim',
        dependencies = 'kyazdani42/nvim-web-devicons',
        config = get_config('bufferline'),
    },

    {
        'lewis6991/gitsigns.nvim',
        config = get_config('gitsigns'),
    },

    {
        'sindrets/diffview.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        config = true,
        cmd = { 'DiffviewOpen' },
    },

    {
        'TimUntersberger/neogit',
        cmd = 'Neogit',
        keys = { { '<leader>G', '<Cmd>Neogit<CR>', desc = 'Neogit' } },
        dependencies = 'nvim-lua/plenary.nvim',
        config = get_config('neogit'),
    },

    {
        'RRethy/vim-illuminate',
        config = get_config('illuminate'),
    },

    {
        'akinsho/toggleterm.nvim',
        config = get_config('toggleterm'),
    },

    -- 『盘古之白』中文排版自动规范化的 Vim 插件
    { 'hotoo/pangu.vim', cmd = 'Pangu' },

    -- A modern vim plugin for editing LaTeX files.
    {
        'lervag/vimtex',
        config = get_config('vimtex'),
    },

    {
        'lukas-reineke/indent-blankline.nvim',
        config = get_config('indent-blankline'),
    },

    {
        'tyru/open-browser.vim',
        config = get_config('open-browser'),
    },

    -- Markdown preview plugin for Neovim
    {
        'toppair/peek.nvim',
        build = 'deno task --quiet build:fast',
        cmd = { 'PeekOpen' },
        keys = { { '<leader>p', '<Cmd>lua require("peek").open()<CR>', desc = 'PeekOpen' } },
        config = get_config('peek'),
    },

    -- Asynchronous translating plugin for Vim/Neovim
    {
        'voldikss/vim-translator',
        config = get_config('translator'),
    },

    {
        'zegervdv/nrpattern.nvim',
        config = get_config('nrpattern'),
    },

    {
        'saifulapm/chartoggle.nvim',
        config = get_config('chartoggle'),
    },

    {
        'rktjmp/paperplanes.nvim',
        config = get_config('paperplanes'),
    },

    {
        'kevinhwang91/nvim-bqf',
        config = get_config('bqf'),
    },

    {
        'alohaia/fcitx.nvim',
        config = get_config('fcitx'),
    },

    { 'chrisbra/csv.vim', ft = 'csv' },
    { 'mtdl9/vim-log-highlighting', ft = 'log' },
}
