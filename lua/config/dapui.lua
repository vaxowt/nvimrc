local dap, dapui = require('dap'), require('dapui')

dapui.setup()

dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
    dapui.close()
    print('terminated')
end
dap.listeners.before.event_exited['dapui_config'] = function()
    dapui.close()
end

vim.keymap.set('n', '<Leader>du', function()
    require('dapui').toggle()
end, { desc = '[dap] toggle dapui' })
