return {
    {
        'olimorris/codecompanion.nvim',
        opts = {
            opts = {
                -- language = 'Chinese',
                -- log_level = 'DEBUG',
            },
            strategies = {
                -- chat = {
                --     adapter = 'siliconflow_qwen',
                -- },
                -- inline = {
                --     adapter = 'siliconflow_qwen',
                -- },
                -- cmd = {
                --     adapter = 'siliconflow_qwen',
                -- },
            },
            adapters = {
                http = {
                    ark = function()
                        return require('codecompanion.adapters').extend('openai_compatible', {
                            name = 'Ark',
                            formatted_name = 'Ark',
                            url = 'https://ark.cn-beijing.volces.com/api/v3/chat/completions',
                            env = {
                                api_key = function()
                                    return os.getenv('ARK_API_KEY')
                                end,
                            },
                            schema = {
                                model = {
                                    default = 'deepseek-v3-1-250821',
                                    choices = {
                                        'deepseek-v3-1-250821',
                                        'doubao-seed-1-6-250615',
                                        'doubao-seed-1-6-flash-250828',
                                    },
                                },
                            },
                        })
                    end,
                    siliconflow_ds = function()
                        return require('codecompanion.adapters').extend('deepseek', {
                            name = 'siliconflow_ds',
                            formatted_name = 'DeepSeek - SiliconFlow',
                            url = 'https://api.siliconflow.cn/v1/chat/completions',
                            env = {
                                api_key = function()
                                    return os.getenv('SILICONFLOW_API_KEY')
                                end,
                            },
                            schema = {
                                model = {
                                    default = 'deepseek-ai/DeepSeek-V3',
                                    choices = {
                                        ['deepseek-ai/DeepSeek-R1'] = { opts = { can_reason = true } },
                                        ['deepseek-ai/DeepSeek-V3'] = { opts = { can_reason = false } },
                                    },
                                },
                            },
                        })
                    end,
                    siliconflow_qwen = function()
                        return require('codecompanion.adapters').extend('openai_compatible', {
                            name = 'siliconflow_qwen',
                            formatted_name = 'QWen - SiliconFlow',
                            url = 'https://api.siliconflow.cn/v1/chat/completions',
                            env = {
                                api_key = function()
                                    return os.getenv('SILICONFLOW_API_KEY')
                                end,
                            },
                            schema = {
                                model = {
                                    default = 'Qwen/Qwen2.5-Coder-32B-Instruct',
                                    choices = {
                                        'Qwen/Qwen2.5-Coder-32B-Instruct',
                                        'Qwen/Qwen2.5-Coder-7B-Instruct',
                                    },
                                },
                            },
                        })
                    end,
                },
            },
        },
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            { 'zbirenbaum/copilot.lua', opts = {}, cmd = 'Copilot' },
        },
        keys = {
            -- stylua: ignore start
            { '<leader>aA', '<CMD>CodeCompanion<CR>', mode = { 'n', 'v' }, desc = 'ai: codecompanion' },
            { '<leader>aa', '<CMD>CodeCompanionActions<CR>', mode = { 'n', 'v' }, desc = 'ai: codecompanion actions' },
            { '<leader>ae', '<CMD>CodeCompanion /explain<CR>', mode = { 'n', 'v' }, desc = 'ai: codecompanion /explain' },
            { '<leader>am', '<CMD>CodeCompanion /commit<CR>', mode = { 'n', 'v' }, desc = 'ai: codecompanion /commit' },
            { '<leader>ac', '<CMD>CodeCompanionChat<CR>', mode = { 'n', 'v' }, desc = 'ai: codecompanion chat' },
            { '<leader>ai', '<CMD>CodeCompanionChat Add<CR>', mode = 'v', desc = 'ai: codecompanion chat' },
            -- stylua: ignore stop
        },
        cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionActions' },
    },
}
