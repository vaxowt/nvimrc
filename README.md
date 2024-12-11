# My Neovim Configuration

## Requirements

* [fzf](https://github.com/junegunn/fzf): required by nvim-telescope/telescope-fzf-native.nvim
* [deno](https://deno.com/): required by toppair/peek.nvim

## Installation

* Clone into `${XGD_CONFIG_HOME}/nvim`
* Open neovim, wait for Installation

## Get Started

* Use `:Lazy` (or <kbd><SPACE>z</kbd>) to manage plugins with lazy.nvim
* Use `:Mason` to manage LSPs, DAPs, linters and formatters
* Use `:TSxxxx` commands (e.g., `:TSInstallInfo`) to manage treesitter parsers
* Use <kbd>-</kbd> to manage files with lir.nvim.
* Use <kbd><SPACE>fM</kbd> to find the custom keymaps.
* Some *magic* keymaps:

| Mode | Keymap | Description |
|--|--|--|
| i | <kbd>CTRL-h</kbd>/<kbd>CTRL-l</kbd> | move cursor left/right |
| i,n | <kbd>ALT-z</kbd> | toggle terminal |
