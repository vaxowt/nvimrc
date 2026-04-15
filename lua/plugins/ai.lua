return {
    {
        'olimorris/codecompanion.nvim',
        opts = {
            opts = {
                -- language = 'Chinese',
                -- log_level = 'DEBUG',
            },
            interactions = {
                chat = {
                    adapter = 'copilot',
                },
                inline = {
                    adapter = 'copilot',
                },
                cmd = {
                    adapter = 'copilot',
                },
            },
            adapters = {
                http = {
                    ollama = function()
                        return require('codecompanion.adapters').extend('ollama', {
                            schema = {
                                model = {
                                    default = 'carstenuhlig/omnicoder-2-9b:latest',
                                    choices = {
                                        'carstenuhlig/omnicoder-2-9b:latest',
                                        'qwen3-coder:latest',
                                    },
                                },
                                num_ctx = {
                                    default = 16384,
                                },
                            },
                        })
                    end,
                    openrouter = function()
                        return require('codecompanion.adapters').extend('openai_compatible', {
                            name = 'openrouter',
                            formatted_name = 'OpenRouter',
                            url = 'https://openrouter.ai/api/v1/chat/completions',
                            env = {
                                api_key = function()
                                    return os.getenv('OPENROUTER_API_KEY')
                                end,
                            },
                            schema = {
                                model = {
                                    default = 'google/gemma-4-31b-it:free',
                                    choices = {
                                        'nvidia/nemotron-3-super-120b-a12b:free',
                                        'openrouter/elephant-alpha',
                                        'arcee-ai/trinity-large-preview:free',
                                        'z-ai/glm-4.5-air:free',
                                        'openai/gpt-oss-120b:free',
                                        'nvidia/nemotron-3-nano-30b-a3b:free',
                                        'minimax/minimax-m2.5:free',
                                        'google/gemma-4-31b-it:free',
                                        'qwen/qwen3-coder:free',
                                    },
                                },
                            },
                        })
                    end,
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
                    siliconflow = function()
                        return require('codecompanion.adapters').extend('openai_compatible', {
                            name = 'siliconflow',
                            formatted_name = 'SiliconFlow',
                            url = 'https://api.siliconflow.cn/v1/chat/completions',
                            env = {
                                api_key = function()
                                    return os.getenv('SILICONFLOW_API_KEY')
                                end,
                            },
                            schema = {
                                model = {
                                    default = 'Pro/zai-org/GLM-5.1',
                                    choices = {
                                        'Pro/zai-org/GLM-5.1',
                                        'Pro/MiniMaxAI/MiniMax-M2.5',
                                        'Pro/deepseek-ai/DeepSeek-V3.2',
                                        'Qwen/Qwen3.5-397B-A17B',
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
