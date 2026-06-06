return {
    -- A Neovim plugin for storing and restoring fcitx status of several mode
    -- groups separately.
    {
        'alohaia/fcitx.nvim',
        enabled = function()
            return vim.env.DISPLAY ~= nil
        end,
        config = function()
            require('fcitx')({})
        end,
    },

    -- A Neovim plugin for switching input method on Windows.
    {
        'vaxowt/aimswitcher.nvim',
        enabled = vim.fn.has('win32') == 1,
        opts = {
            default_ime = {
                method = '2052',
                mode = '0',
            },
        },
    },
}
