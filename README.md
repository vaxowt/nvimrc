# My Neovim Configuration

## Requirements

* [deno](https://deno.com/): required by toppair/peek.nvim
* [ripgrep](https://github.com/BurntSushi/ripgrep): required by vim.health, grug-far.nvim, snacks.nvim
* [fd](https://github.com/sharkdp/fd): required by snacks.nvim
* [yazi](https://github.com/sxyazi/yazi): required by mikavilpas/yazi.nvim

## Installation

* Clone into `${XGD_CONFIG_HOME}/nvim`
* Open neovim, wait for Installation

## Get Started

* Use `:Lazy` (or <kbd>SPACE</kbd><kbd>Z</kbd>) to manage plugins with lazy.nvim
* Use `:Mason` to manage LSPs, DAPs, linters and formatters
* Use `:TSxxxx` commands (e.g., `:TSInstallInfo`) to manage treesitter parsers
* Use <kbd>-</kbd> to manage files with lir.nvim.
* Use <kbd>SPACE</kbd><kbd>f</kbd><kbd>M</kbd> to find the custom keymaps.
* Some *magic* keymaps:

| Mode | Keymap | Description |
|--|--|--|
| i | <kbd>CTRL</kbd><kbd>h</kbd>/<kbd>CTRL</kbd><kbd>l</kbd> | move cursor left/right |
| i,n | <kbd>ALT</kbd><kbd>z</kbd> | toggle terminal |
