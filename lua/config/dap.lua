local dap = require('dap')

vim.keymap.set('n', '<F5>', function()
    require('dap').continue()
end, { desc = '[dap] continue' })
vim.keymap.set('n', '<F10>', function()
    require('dap').step_over()
end, { desc = '[dap] step_over' })
vim.keymap.set('n', '<F11>', function()
    require('dap').step_into()
end, { desc = '[dap] step_into' })
vim.keymap.set('n', '<F12>', function()
    require('dap').step_out()
end, { desc = '[dap] step_out' })
vim.keymap.set('n', '<Leader>b', function()
    require('dap').toggle_breakpoint()
end, { desc = '[dap] toggle breakpoint' })
vim.keymap.set('n', '<Leader>B', function()
    require('dap').set_breakpoint()
end, { desc = '[dap] set breakpoint' })
vim.keymap.set('n', '<Leader>lp', function()
    require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end, { desc = '[dap] set breakpoint with log' })
vim.keymap.set('n', '<Leader>dr', function()
    require('dap').repl.open()
end, { desc = '[dap] open repl' })
vim.keymap.set('n', '<Leader>dl', function()
    require('dap').run_last()
end, { desc = '[dap] run last' })
vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
    require('dap.ui.widgets').hover()
end, { desc = '[dap] hover info' })
vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
    require('dap.ui.widgets').preview()
end, { desc = '[dap] preview' })
vim.keymap.set('n', '<Leader>df', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
end, { desc = '[dap] frames ui' })
vim.keymap.set('n', '<Leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
end, { desc = '[dap] scopes ui' })

dap.adapters.codelldb = {
    type = 'server',
    port = '${port}',
    executable = {
        command = 'codelldb',
        args = { '--port', '${port}' },

        -- On windows you may have to uncomment this:
        -- detached = false,
    },
}

dap.configurations.cpp = {
    {
        name = 'Launch file',
        type = 'codelldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
    },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
