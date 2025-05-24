return {
    {
        'alohaia/fcitx.nvim',
        enabled = function()
            return vim.env.DISPLAY ~= nil
        end,
        config = function()
            require('fcitx')({})
        end,
    },

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
