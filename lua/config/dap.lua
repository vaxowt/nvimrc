local dap = require('dap')

vim.cmd([[autocmd FileType dap-float nnoremap <buffer><silent> q <cmd>close!<CR>]])
vim.cmd([[autocmd FileType dap-float nnoremap <buffer><silent> <Esc> <cmd>close!<CR>]])

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

local function load_config(opts)
    local config_file = vim.fn.getcwd() .. '/' .. 'dap-config.lua'
    if opts.args ~= '' then
        config_file = opts.args
    end
    local config_env = {}
    local f, err = loadfile(config_file, 't', config_env)
    if not f then
        print('Can not load file: ' .. err)
        return
    end
    local ok, ret = pcall(f)
    if not ok then
        print('Can not load file: ' .. ret)
        return
    end
    dap.configurations[vim.bo.filetype] = ret
    print('Config file loaded: ' .. config_file)
end

vim.api.nvim_create_user_command('DapLoadConfig', function(opts)
    load_config(opts)
end, { nargs = '?', complete = 'file' })

local function get_program()
    return function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end
end

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

dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = 'OpenDebugAD7',
    options = {
        -- detached = false,
    },
}

dap.adapters.python = function(cb, config)
    if config.request == 'attach' then
        ---@diagnostic disable-next-line: undefined-field
        local port = (config.connect or config).port
        ---@diagnostic disable-next-line: undefined-field
        local host = (config.connect or config).host or '127.0.0.1'
        cb({
            type = 'server',
            port = assert(port, '`connect.port` is required for a python `attach` configuration'),
            host = host,
            options = {
                source_filetype = 'python',
            },
        })
    else
        local command = vim.fn.exepath('debugpy-adapter')
        local args = nil
        -- HACK: debugpy-adapter.cmd not work
        if vim.fn.has('win32') then
            local mason_registry = require('mason-registry')
            local debugpy_path = mason_registry.get_package('debugpy'):get_install_path()
            command = debugpy_path .. '/venv/Scripts/python.exe'
            args = { '-m', 'debugpy.adapter' }
        end
        cb({
            type = 'executable',
            command = command,
            args = args,
            options = {
                source_filetype = 'python',
            },
        })
    end
end

dap.configurations.cpp = {
    {
        name = 'Launch file',
        type = 'codelldb',
        request = 'launch',
        program = get_program(),
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
    },
}

dap.configurations.rust = dap.configurations.cpp

dap.configurations.c = {
    {
        name = 'Launch (codelldb)',
        type = 'codelldb',
        request = 'launch',
        program = get_program(),
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
    },
    {
        name = 'Launch (cpptools)',
        type = 'cppdbg',
        request = 'launch',
        program = get_program(),
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
    },
    {
        name = 'Remote attach gdb (cpptools)',
        type = 'cppdbg',
        request = 'launch',
        MIMode = 'gdb',
        miDebuggerServerAddress = 'localhost:3333',
        miDebuggerPath = 'arm-none-eabi-gdb',
        cwd = '${workspaceFolder}',
        program = get_program(),
        stopAtEntry = false,
    },
}

dap.configurations.python = {
    {
        type = 'python',
        request = 'launch',
        name = 'Launch file',

        -- Options below are for debugpy, see
        -- https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
        program = '${file}',
        pythonPath = 'python',
    },
    {
        type = 'python',
        request = 'launch',
        name = 'Launch file with arguments',
        program = '${file}',
        pythonPath = 'python',
        args = function()
            local input = vim.fn.input('Arguments: ')
            for k, v in pairs(vim.split(input, ' ')) do
                print(v)
            end
            return vim.split(input, ' ')
        end,
    },
}
