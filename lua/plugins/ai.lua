return {
    -- AI Coding, Vim Style.
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
                    llama_cpp = function()
                        return require('codecompanion.adapters').extend('openai', {
                            name = 'llama_cpp',
                            formatted_name = 'LLaMA.cpp',
                            url = 'http://localhost:8080/v1/chat/completions',
                            env = {
                                api_key = function()
                                    return os.getenv('LLAMA_API_KEY')
                                end,
                            },
                            schema = {
                                model = {
                                    default = 'Tesslate/OmniCoder-9B-GGUF',
                                    choices = {
                                        'Tesslate/OmniCoder-9B-GGUF',
                                    },
                                },
                            },
                            handlers = {
                                form_messages = function(self, messages)
                                    local system_content = {}
                                    local other_messages = {}
                                    -- 1. Separate system messages from everything else
                                    for _, msg in ipairs(messages) do
                                        if msg.role == 'system' then
                                            table.insert(system_content, msg.content)
                                        else
                                            table.insert(other_messages, msg)
                                        end
                                    end
                                    local final_messages = {}
                                    -- 2. If there are system messages, merge them into ONE message at the top
                                    if #system_content > 0 then
                                        table.insert(final_messages, {
                                            role = 'system',
                                            content = table.concat(system_content, '\n\n'),
                                        })
                                    end
                                    -- 3. Append all the user/assistant messages
                                    for _, msg in ipairs(other_messages) do
                                        table.insert(final_messages, msg)
                                    end
                                    -- 4. Pass the cleaned messages to the standard OpenAI handler
                                    local openai = require('codecompanion.adapters.http.openai')
                                    return openai.handlers.form_messages(self, final_messages)
                                end,
                                parse_message_meta = function(self, data)
                                    local extra = data.extra
                                    if extra and extra.reasoning_content then
                                        data.output.reasoning = { content = extra.reasoning_content }
                                        if data.output.content == '' then
                                            data.output.content = nil
                                        end
                                    end
                                    return data
                                end,
                            },
                        })
                    end,
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
                    deepseek_no_reasoning = function()
                        return require('codecompanion.adapters').extend('deepseek', {
                            name = 'deepseek_no_reasoning',
                            formatted_name = 'DeepSeek No Thinking',
                            schema = {
                                ['thinking.type'] = { default = 'disabled' },
                            },
                        })
                    end,
                    openrouter = function()
                        return require('codecompanion.adapters').extend('openai', {
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
                                    default = 'openrouter/owl-alpha',
                                    choices = {
                                        'openrouter/owl-alpha',
                                        'nvidia/nemotron-3-ultra-550b-a55b:free',
                                        'poolside/laguna-m.1:free',
                                        'nvidia/nemotron-3-super-120b-a12b:free',
                                        'openai/gpt-oss-120b:free',
                                        'nex-agi/nex-n2-pro:free',
                                        'poolside/laguna-xs.2:free',
                                        'openai/gpt-oss-20b:free',
                                        'google/gemma-4-31b-it:free',
                                        'nvidia/nemotron-3-nano-30b-a3b:free',
                                        'nvidia/nemotron-3-nano-omni-30b-a3b-reasoning:free',
                                        'nvidia/nemotron-nano-12b-v2-vl:free',
                                        'nvidia/nemotron-nano-9b-v2:free',
                                        'google/gemma-4-26b-a4b-it:free',
                                        'liquid/lfm-2.5-1.2b-thinking:free',
                                        'nvidia/nemotron-3.5-content-safety:free',
                                        'liquid/lfm-2.5-1.2b-instruct:free',
                                        'qwen/qwen3-next-80b-a3b-instruct:free',
                                        'meta-llama/llama-3.3-70b-instruct:free',
                                        'cognitivecomputations/dolphin-mistral-24b-venice-edition:free',
                                    },
                                },
                            },
                        })
                    end,
                    ark = function()
                        return require('codecompanion.adapters').extend('openai', {
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
                        local openai_adapter = require('codecompanion.adapters.http.openai')
                        return require('codecompanion.adapters').extend('openai', {
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
                            handlers = {
                                chat_output = function(self, data, tools)
                                    local result = openai_adapter.handlers.chat_output(self, data, tools)
                                    if result and result.output then
                                        -- Filter empty string content to prevent blank lines in chat
                                        if result.output.content == '' then
                                            result.output.content = nil
                                        end
                                        -- Skip chunks that carry no meaningful data
                                        if not result.output.content and not result.output.role then
                                            return nil
                                        end
                                    end
                                    return result
                                end,
                            },
                        })
                    end,
                },
            },
            prompt_library = {
                markdown = {
                    dirs = {
                        vim.fn.getcwd() .. '/.prompts',
                        vim.fn.stdpath('config') .. '/prompts',
                    },
                },
            },
            extensions = {
                agentskills = {
                    opts = {
                        paths = {
                            { '~/.config/skills', recursive = true },
                        },
                    },
                },
                history = {
                    enabled = true,
                    opts = {
                        -- Keymap to open history from chat buffer (default: gh)
                        keymap = 'gh',
                        -- Keymap to save the current chat manually (when auto_save is disabled)
                        save_chat_keymap = 'sc',
                        -- Save all chats by default (disable to save only manually using 'sc')
                        auto_save = false,
                        -- Number of days after which chats are automatically deleted (0 to disable)
                        expiration_days = 0,
                        -- Picker interface (auto resolved to a valid picker)
                        picker = 'snacks', --- ("telescope", "snacks", "fzf-lua", or "default")
                        ---Optional filter function to control which chats are shown when browsing
                        chat_filter = nil, -- function(chat_data) return boolean end
                        -- Customize picker keymaps (optional)
                        picker_keymaps = {
                            rename = { n = 'r', i = '<M-r>' },
                            delete = { n = 'd', i = '<M-d>' },
                            duplicate = { n = '<C-y>', i = '<C-y>' },
                        },
                        ---Automatically generate titles for new chats
                        auto_generate_title = false,
                        title_generation_opts = {
                            ---Adapter for generating titles (defaults to current chat adapter)
                            adapter = nil, -- "copilot"
                            ---Model for generating titles (defaults to current chat model)
                            model = nil, -- "gpt-4o"
                            ---Number of user prompts after which to refresh the title (0 to disable)
                            refresh_every_n_prompts = 0, -- e.g., 3 to refresh after every 3rd user prompt
                            ---Maximum number of times to refresh the title (default: 3)
                            max_refreshes = 3,
                            format_title = function(original_title)
                                -- this can be a custom function that applies some custom
                                -- formatting to the title.
                                return original_title
                            end,
                        },
                        ---On exiting and entering neovim, loads the last chat on opening chat
                        continue_last_chat = false,
                        ---When chat is cleared with `gx` delete the chat from history
                        delete_on_clearing_chat = false,
                        ---Directory path to save the chats
                        dir_to_save = vim.fn.stdpath('data') .. '/codecompanion-history',
                        ---Enable detailed logging for history extension
                        enable_logging = false,

                        -- Summary system
                        summary = {
                            -- Keymap to generate summary for current chat (default: "gcs")
                            create_summary_keymap = 'gcs',
                            -- Keymap to browse summaries (default: "gbs")
                            browse_summaries_keymap = 'gbs',

                            generation_opts = {
                                adapter = nil, -- defaults to current chat adapter
                                model = nil, -- defaults to current chat model
                                context_size = 90000, -- max tokens that the model supports
                                include_references = true, -- include slash command content
                                include_tool_outputs = true, -- include tool execution results
                                system_prompt = nil, -- custom system prompt (string or function)
                                format_summary = nil, -- custom function to format generated summary e.g to remove <think/> tags from summary
                            },
                        },

                        -- Memory system (requires VectorCode CLI)
                        memory = {
                            -- Automatically index summaries when they are generated
                            auto_create_memories_on_summary_generation = true,
                            -- Path to the VectorCode executable
                            vectorcode_exe = 'vectorcode',
                            -- Tool configuration
                            tool_opts = {
                                -- Default number of memories to retrieve
                                default_num = 10,
                            },
                            -- Enable notifications for indexing progress
                            notify = true,
                            -- Index all existing memories on startup
                            -- (requires VectorCode 0.6.12+ for efficient incremental indexing)
                            index_on_startup = false,
                        },
                    },
                },
            },
        },
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            { 'zbirenbaum/copilot.lua', opts = {}, cmd = 'Copilot' },
            'ravitemer/codecompanion-history.nvim',
            'cairijun/codecompanion-agentskills.nvim',
        },
        keys = {
            -- stylua: ignore start
            { '<leader>aA', '<CMD>CodeCompanion<CR>', mode = { 'n', 'v' }, desc = 'ai: codecompanion' },
            { '<leader>aa', '<CMD>CodeCompanionActions<CR>', mode = { 'n', 'v' }, desc = 'ai: codecompanion actions' },
            { '<leader>ae', '<CMD>CodeCompanion /explain<CR>', mode = { 'n', 'v' }, desc = 'ai: codecompanion /explain' },
            { '<leader>am', '<CMD>CodeCompanion /commit2<CR>', mode = { 'n', 'v' }, desc = 'ai: codecompanion /commit' },
            { '<leader>ac', '<CMD>CodeCompanionChat<CR>', mode = { 'n', 'v' }, desc = 'ai: codecompanion chat' },
            { '<leader>ai', '<CMD>CodeCompanionChat Add<CR>', mode = 'v', desc = 'ai: codecompanion chat' },
            { '<leader>ah', '<CMD>CodeCompanionHistory<CR>', mode = {'n', 'v'}, desc = 'ai: codecompanion history' },
            { '<leader>as', '<CMD>CodeCompanionSummaries<CR>', mode = {'n', 'v'}, desc = 'ai: codecompanion summaries' },
            -- stylua: ignore stop
        },
        cmd = {
            'CodeCompanion',
            'CodeCompanionChat',
            'CodeCompanionActions',
            'CodeCompanionHistory',
            'CodeCompanionSummaries',
        },
    },
}
