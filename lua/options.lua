-- interval for writing the swapfile to disk
vim.o.updatetime = 300
-- time to wait for a key code sequence to complete
vim.o.ttimeoutlen = 0
-- default split direction
vim.o.splitbelow = true
-- default vsplit direction
vim.o.splitright = true
-- change <leader> (default `\`)
vim.g.mapleader = ' '
-- change <localleader> (default `\`)
vim.g.maplocalleader = ' '
-- enable 24-bit RGB color in the TUI
vim.o.termguicolors = true
-- enable mouse support
vim.o.mouse = 'a'
-- ignore case in search patterns
vim.o.ignorecase = true
-- be case-sensitive if the search pattern contains upper case characters
vim.o.smartcase = true
-- do smart autoindenting when starting a new line
vim.o.smartindent = true
-- expand <Tab> to spaces (CTRL-V<Tab> for a real tab)
-- NOTE: see :help 'tabstop'
vim.o.expandtab = true
-- number of spaces a <Tab> in the file counts for
vim.o.tabstop = 4
-- number of spaces to use for each step of (auto)indent
vim.o.shiftwidth = 4
-- automatic formatting options
-- m: allow break at a multi-byte character above 255 (for CJK)
-- M: don't insert space between two multi-byte characters when joining lines (for CJK)
vim.o.formatoptions = vim.o.formatoptions .. 'mB'
-- check spells for these languages
-- cjk: exclude CJK characters
vim.o.spelllang = 'en_us,cjk'
-- show the number column
vim.o.number = true
-- don't show mode message
vim.o.showmode = false
-- always show the signcolumn
vim.o.signcolumn = 'yes'
-- highlight the line of the cursor
vim.o.cursorline = true
-- show at least 2 line above/below the cursor
vim.o.scrolloff = 2
-- maximum number of items to show in the completion menu
vim.o.pumheight = 30
-- show special characters
vim.o.list = true
vim.o.listchars = 'tab:> ,trail:·,extends:>,precedes:<,nbsp:+'
-- show 'hit top/bottom' message
vim.opt.shortmess:append({ S = true, })
-- indent wrapped line visually
vim.o.breakindent = true
-- persistent undo history
vim.o.undofile = true

-- Python 3 executable path (faster startup)
vim.g.python3_host_prog = 'python'

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- enable Lua filetype detection
vim.g.do_filetype_lua = 1
-- TODO: vim filetype detection may be disabled in the future
-- vim.g.did_load_filetypes = 0
