-- bootstrap
local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
    Packer_bootstrap = vim.fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        packer_path,
    })
end

local function get_config(name)
    return string.format('require("config/%s")', name)
end

local packer = require("packer")

packer.init({
    enable = true,
    threshold = 0,
})

packer.startup(function(use)
    -- A use-package inspired plugin manager for Neovim.
    -- Uses native packages, supports Luarocks dependencies,
    -- written in Lua,
    -- allows for expressive config
    use("wbthomason/packer.nvim")

    -- Nvim Treesitter configurations and abstraction layer
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = get_config("treesitter"),
    })

    -- Neovim plugin that allows you to seamlessly manage LSP servers with :LspInstall
    use({
        "williamboman/nvim-lsp-installer",
        -- Quickstart configurations for the Nvim LSP client
        {
            "neovim/nvim-lspconfig",
            config = get_config("lspconfig"),
        },
    })

    -- A completion plugin for neovim coded in Lua
    use({
        "hrsh7th/nvim-cmp",
        requires = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lsp-signature-help" },
            { "hrsh7th/cmp-nvim-lsp-document-symbol" },
            { "hrsh7th/cmp-vsnip" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/cmp-calc" },
            { "hrsh7th/cmp-emoji" },
            { "uga-rosa/cmp-dictionary" },
            { 'andersevenrud/cmp-tmux' },
            { 'max397574/cmp-greek' },
        },
        config = get_config("cmp"),
    })

    use({
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = get_config("lualine"),
    })

    use({
        "hrsh7th/vim-vsnip",
        config = get_config("vsnip"),
    })

    use("rafamadriz/friendly-snippets")

    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            { "nvim-lua/plenary.nvim" },
        },
        config = get_config("telescope"),
    })

    use("dstein64/vim-startuptime")

    -- Gruvbox with Material Palette
    use({
        "sainnhe/gruvbox-material",
        config = get_config("gruvbox-material"),
    })
    -- Comfortable & Pleasant Color Scheme for Vim
    use("sainnhe/everforest")
    -- An arctic, north-bluish clean and elegant Vim theme
    use 'arcticicestudio/nord-vim'
    -- A simplified and optimized Gruvbox colorscheme for Vim
    use 'lifepillar/vim-gruvbox8'
    -- A dark Vim/Neovim color scheme inspired by Atom's One Dark syntax theme.
    use 'joshdick/onedark.vim'
    -- Clean & Elegant Color Scheme for Vim, Zsh and Terminal Emulators
    use 'sainnhe/edge'
    -- Dark blue color scheme for Vim and Neovim
    use 'cocopon/iceberg.vim'
    -- A better color scheme for the late night coder
    use 'ajmwagar/vim-deus'
    -- A Vim colorscheme based on Github's syntax highlighting as of 2018.
    use 'cormacrelf/vim-colors-github'


    use({
        "windwp/nvim-autopairs",
        config = get_config("autopairs"),
    })

    use({
        "numToStr/Comment.nvim",
        config = get_config("comment"),
    })

    use({
        "tamago324/lir.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
        },
        config = get_config("lir"),
    })

    -- Auto-toggle hlsearch, and show number of matches
    use("romainl/vim-cool")

    -- A (Neo)vim plugin for formatting code.
    use("sbdchd/neoformat")

    use({
        "machakann/vim-sandwich",
        config = get_config("sandwich"),
    })

    --  A Vim alignment plugin
    use({
        "junegunn/vim-easy-align",
        config = get_config("easy-align"),
    })

    use({
        "ggandor/lightspeed.nvim",
        config = get_config("lightspeed"),
    })

    use({
        "simrat39/symbols-outline.nvim",
        cmd = { 'SymbolsOutline', 'SymbolsOutlineOpen', 'SymbolsOutlineClose' },
        config = get_config("symbols-outline"),
    })

    use({
        "lewis6991/gitsigns.nvim",
        config = get_config("gitsigns"),
    })

    use({
        "sindrets/diffview.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = get_config("diffview"),
    })

    use({
        "TimUntersberger/neogit",
        requires = "nvim-lua/plenary.nvim",
        config = get_config("neogit"),
    })

    use({
        "f-person/git-blame.nvim",
        config = get_config("git-blame"),
    })

    use({
        "RRethy/vim-illuminate",
        config = get_config("illuminate"),
    })

    use({
        "akinsho/toggleterm.nvim",
        config = get_config("toggleterm"),
    })

    -- 『盘古之白』中文排版自动规范化的 Vim 插件
    use("hotoo/pangu.vim")
    -- A modern vim plugin for editing LaTeX files.
    use({
        "lervag/vimtex",
        config = get_config("vimtex"),
    })

    use({
        "nvim-treesitter/nvim-treesitter-textobjects",
    })

    use({
        "tyru/open-browser.vim",
        config = get_config("open-browser"),
    })

    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && yarn install",
        cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
        config = get_config("markdown-preview"),
    })

    -- Asynchronous translating plugin for Vim/Neovim
    use({
        "voldikss/vim-translator",
        config = get_config("translator"),
    })

    use({
        "zegervdv/nrpattern.nvim",
        config = get_config("nrpattern"),
    })

    use {
        'brglng/vim-im-select',
        config = get_config("im-select"),
    }

    if Packer_bootstrap then
        require("packer").sync()
    end
end)
