-- bootstrap
local packer_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
    Packer_bootstrap = vim.fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        packer_path,
    })
end

local function get_config(name)
    return string.format('require("config/%s")', name)
end

local packer = require('packer')

packer.startup({
    function(use)
        -- A use-package inspired plugin manager for Neovim.
        -- Uses native packages, supports Luarocks dependencies,
        -- written in Lua,
        -- allows for expressive config
        use('wbthomason/packer.nvim')

        use({
            'lewis6991/impatient.nvim',
            config = function()
                -- require('impatient').enable_profile()
                require('impatient')
            end,
        })

        use({
            'luukvbaal/stabilize.nvim',
            config = get_config('stabilize'),
        })

        -- Nvim Treesitter configurations and abstraction layer
        use({
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate',
            config = get_config('treesitter'),
        })

        -- Neovim plugin that allows you to seamlessly manage LSP servers with :LspInstall
        use({
            'williamboman/nvim-lsp-installer',
        })

        -- Quickstart configurations for the Nvim LSP client
        use({
            'neovim/nvim-lspconfig',
            config = get_config('lspconfig'),
            after = { 'nvim-lsp-installer', 'vim-illuminate' },
        })

        -- A completion plugin for neovim coded in Lua
        use({
            'hrsh7th/nvim-cmp',
            requires = {
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
        })

        use({
            'nvim-lualine/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true },
            config = get_config('lualine'),
        })

        use({
            'dcampos/nvim-snippy',
            config = get_config('snippy'),
        })

        use('honza/vim-snippets')

        use({
            'nvim-telescope/telescope.nvim',
            requires = {
                { 'nvim-lua/plenary.nvim' },
                { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
                { 'nvim-telescope/telescope-symbols.nvim' },
                { 'cljoly/telescope-repo.nvim' },
            },
            config = get_config('telescope'),
        })

        use('dstein64/vim-startuptime')

        use({
            'ahmedkhalf/project.nvim',
            requires = 'nvim-telescope/telescope.nvim',
            config = get_config('project'),
        })

        use({
            'olimorris/persisted.nvim',
            requires = 'nvim-telescope/telescope.nvim',
            --module = "persisted", -- For lazy loading
            config = get_config('persisted'),
        })

        use({
            'EdenEast/nightfox.nvim',
            config = get_config('nightfox'),
        })
        use({ 'catppuccin/nvim', as = 'catppuccin' })
        use({
            'marko-cerovac/material.nvim',
        })
        use('projekt0n/github-nvim-theme')
        use('ful1e5/onedark.nvim')
        -- Gruvbox with Material Palette
        use({
            'sainnhe/gruvbox-material',
            -- load config first
            config = get_config('gruvbox-material'),
        })
        -- Comfortable & Pleasant Color Scheme for Vim
        use({
            'sainnhe/everforest',
            config = get_config('everforest'),
        })
        use({
            'sainnhe/edge',
            config = get_config('edge'),
        })
        -- An arctic, north-bluish clean and elegant Vim theme
        use('shaunsingh/nord.nvim')

        use({
            'windwp/nvim-autopairs',
            config = get_config('autopairs'),
        })

        use({
            'numToStr/Comment.nvim',
            config = get_config('comment'),
        })

        use({
            'tamago324/lir.nvim',
            requires = {
                'nvim-lua/plenary.nvim',
            },
            config = get_config('lir'),
        })

        -- Auto-toggle hlsearch, and show number of matches
        use('romainl/vim-cool')

        -- A (Neo)vim plugin for formatting code.
        use({
            'sbdchd/neoformat',
            config = get_config('neoformat'),
        })

        use({
            'machakann/vim-sandwich',
            config = get_config('sandwich'),
        })

        --  A Vim alignment plugin
        use({
            'junegunn/vim-easy-align',
            config = get_config('easy-align'),
        })

        use('tpope/vim-repeat')

        use({
            'ggandor/leap.nvim',
            config = get_config('leap'),
        })

        use({
            'folke/todo-comments.nvim',
            requires = 'nvim-lua/plenary.nvim',
            config = get_config('todo-comments'),
        })

        use({
            'simrat39/symbols-outline.nvim',
            config = get_config('symbols-outline'),
        })

        use({
            'akinsho/bufferline.nvim',
            requires = 'kyazdani42/nvim-web-devicons',
            config = get_config('bufferline'),
        })

        use({
            'lewis6991/gitsigns.nvim',
            config = get_config('gitsigns'),
        })

        use({
            'sindrets/diffview.nvim',
            requires = 'nvim-lua/plenary.nvim',
            config = get_config('diffview'),
        })

        use({
            'TimUntersberger/neogit',
            requires = 'nvim-lua/plenary.nvim',
            config = get_config('neogit'),
        })

        use({
            'RRethy/vim-illuminate',
            config = get_config('illuminate'),
        })

        use({
            'akinsho/toggleterm.nvim',
            config = get_config('toggleterm'),
        })

        -- 『盘古之白』中文排版自动规范化的 Vim 插件
        use('hotoo/pangu.vim')
        -- A modern vim plugin for editing LaTeX files.
        use({
            'lervag/vimtex',
            config = get_config('vimtex'),
        })

        use({
            'nvim-treesitter/nvim-treesitter-textobjects',
            config = get_config('treesitter-textobjects'),
        })

        use({
            'lukas-reineke/indent-blankline.nvim',
            config = get_config('indent-blankline'),
        })

        use({
            'tyru/open-browser.vim',
            config = get_config('open-browser'),
        })

        use({
            'iamcco/markdown-preview.nvim',
            run = 'cd app && yarn install',
            config = get_config('markdown-preview'),
        })

        -- Asynchronous translating plugin for Vim/Neovim
        use({
            'voldikss/vim-translator',
            config = get_config('translator'),
        })

        use({
            'zegervdv/nrpattern.nvim',
            config = get_config('nrpattern'),
        })

        use({
            'saifulapm/chartoggle.nvim',
            config = get_config('chartoggle'),
        })

        use({
            'rktjmp/paperplanes.nvim',
            config = get_config('paperplanes'),
        })

        use({
            'kevinhwang91/nvim-bqf',
            config = get_config('bqf'),
        })

        use({
            'brglng/vim-im-select',
            config = get_config('im-select'),
        })

        use('chrisbra/csv.vim')
        use('mtdl9/vim-log-highlighting')

        if Packer_bootstrap then
            packer.sync()
        end
    end,
    config = {
        -- max_jobs = 8,
        display = {
            open_fn = function()
                return require('packer.util').float({
                    border = 'rounded',
                })
            end,
        },
    },
})
