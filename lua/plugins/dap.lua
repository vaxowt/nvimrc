local map = function(keys, func, desc, mode)
    mode = mode or 'n'
    vim.keymap.set(mode, keys, func, { noremap = true, silent = true, desc = 'dap: ' .. desc })
end

return {
    {
        'mfussenegger/nvim-dap',
        module = true,
        config = function()
            local dap = require('dap')
            local widgets = require('dap.ui.widgets')

            vim.cmd([[autocmd FileType dap-float nnoremap <buffer><silent> q <cmd>close!<CR>]])
            vim.cmd([[autocmd FileType dap-float nnoremap <buffer><silent> <Esc> <cmd>close!<CR>]])

            map('<F5>', dap.continue, 'contiune')
            map('<F10>', dap.step_over, 'step_over')
            map('<F11>', dap.step_into, 'step_into')
            map('<F12>', dap.step_out, 'step_out')
            map('<Leader>b', dap.toggle_breakpoint, 'toggle breakpoint')
            map('<Leader>B', dap.set_breakpoint, 'set breakpoint')
            map('<Leader>lp', function()
                dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
            end, 'set breakpoint with log')
            map('<Leader>dr', dap.repl.open, 'open repl')
            map('<Leader>dl', dap.run_last, 'run last')
            map('<Leader>dh', widgets.hover, 'hover info', { 'n', 'v' })
            map('<Leader>dp', widgets.preview, 'preview', { 'n', 'v' })
            map('<Leader>df', function()
                widgets.centered_float(widgets.frames)
            end, 'frames ui')
            map('<Leader>ds', function()
                widgets.centered_float(widgets.scopes)
            end, 'scopes ui')

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
                    return vim.fn.input('Path to executable: ', vim.fn.fnamemodify(vim.fn.getcwd(), ':p'), 'file')
                end
            end

            local function get_program_ui()
                return function()
                    return coroutine.create(function(co)
                        vim.ui.input({
                            prompt = 'Path to executable',
                            default = vim.fn.fnamemodify(vim.fn.getcwd(), ':p'),
                            completion = 'file',
                            icon = '>', -- require Snacks.input
                        }, function(input)
                            if input == nil or input == '' then
                                coroutine.resume(co, nil)
                            else
                                coroutine.resume(co, input)
                            end
                        end)
                        coroutine.yield()
                    end)
                end
            end

            dap.adapters.codelldb = {
                type = 'server',
                port = '${port}',
                executable = {
                    command = vim.fn.has('win32') == 1 and 'codelldb.cmd' or 'codelldb',
                    args = { '--port', '${port}' },

                    detached = vim.fn.has('win32') ~= 1,
                },
            }

            dap.adapters.cppdbg = {
                id = 'cppdbg',
                type = 'executable',
                command = vim.fn.has('win32') == 1 and 'OpenDebugAD7.cmd' or 'OpenDebugAD7',
                options = {
                    -- detached = true not work on Windows
                    detached = vim.fn.has('win32') ~= 1,
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
                    if vim.fn.has('win32') == 1 then
                        local debugpy_path = vim.fn.stdpath('data') .. '/mason/packages/debugpy'
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
                    program = get_program_ui(),
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
                    program = get_program_ui(),
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                },
                {
                    name = 'Launch (cpptools)',
                    type = 'cppdbg',
                    request = 'launch',
                    program = get_program_ui(),
                    cwd = '${workspaceFolder}',
                    stopAtEntry = true,
                },
                {
                    name = 'Remote attach gdb (cpptools)',
                    type = 'cppdbg',
                    request = 'launch',
                    MIMode = 'gdb',
                    miDebuggerServerAddress = 'localhost:3333',
                    miDebuggerPath = 'gdb',
                    cwd = '${workspaceFolder}',
                    program = get_program_ui(),
                    stopAtEntry = false,
                },
                {
                    name = 'Remote attach arm-none-eabi-gdb (cpptools)',
                    type = 'cppdbg',
                    request = 'launch',
                    MIMode = 'gdb',
                    miDebuggerServerAddress = 'localhost:3333',
                    miDebuggerPath = 'arm-none-eabi-gdb',
                    cwd = '${workspaceFolder}',
                    program = get_program_ui(),
                    stopAtEntry = true,
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
                        for _, v in pairs(vim.split(input, ' ')) do
                            print(v)
                        end
                        return vim.split(input, ' ')
                    end,
                },
            }
        end,
    },

    {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
        config = function()
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

            map('<leader>du', dapui.toggle, 'toggle dapui')
        end,
    },
}
