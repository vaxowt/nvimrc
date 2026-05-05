-- extended from franco-ruggeri/codecompanion-lualine.nvim

local M = require('lualine.component'):extend()

local default_options = {
    icon = '',
    spinner_symbols = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
    done_symbol = '✓',
    show_adapter = true,
    show_model = true,
}

function M:init(options)
    M.super.init(self, options)

    self.options = vim.tbl_deep_extend('keep', self.options or {}, default_options)
    self.n_requests = 0
    self.spinner_index = 0

    vim.api.nvim_create_autocmd('User', {
        pattern = 'CodeCompanionRequestStarted',
        callback = function()
            self.n_requests = self.n_requests + 1
        end,
    })

    vim.api.nvim_create_autocmd('User', {
        pattern = 'CodeCompanionRequestFinished',
        callback = function()
            self.n_requests = self.n_requests - 1
        end,
    })
end

function M:update_status()
    if not package.loaded['codecompanion'] then
        return nil
    end

    if vim.bo.filetype ~= 'codecompanion' then
        return nil
    end

    local adapter = nil
    local model = nil

    if self.options.show_adapter or self.options.show_model then
        local ok, cc = pcall(require, 'codecompanion')
        if not ok then
            return nil
        end

        local chat = cc.buf_get_chat(0)
        adapter = chat.adapter.formatted_name
        model = chat.adapter.model.name
    end

    local symbol = nil
    if self.n_requests > 0 then
        self.spinner_index = (self.spinner_index % #self.options.spinner_symbols) + 1
        symbol = self.options.spinner_symbols[self.spinner_index]
    else
        symbol = self.options.done_symbol
        self.spinner_index = 0
    end

    local content = symbol
    if self.options.show_adapter then
        content = content .. ' ' .. adapter
        model = ('(%s)'):format(model)
    end
    if self.options.show_model then
        content = content .. ' ' .. model
    end

    return content
end

return M
