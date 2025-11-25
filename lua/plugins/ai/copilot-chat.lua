return {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = function()
        if vim.fn.has('win32') ~= 1 then
            return "make tiktoken"
        end
    end,
    -- See Commands section for default commands if you want to lazy load on them
    cmd = {
        "CopilotChat",
        "CopilotChatAccept",
        "CopilotChatNext",
        "CopilotChatPrevious",
        "CopilotChatClear",
    },
    opts = function()
        return {
            question_header = "  You",
            answer_header = "  Copilot ",
            window = {
                width = 0.4,
            },
            ---@type table<string, CopilotChat.config.providers.Provider>
            providers = {
                lmstudio = {
                    get_url = function (opts)
                        return "http://127.0.0.1:1234/v1/chat/completions"
                    end,
                    get_models = function(headers)
                        ---@type table<CopilotChat.client.Model>
                        local vendors = {}
                        local curl = require("CopilotChat.utils.curl")
                        local response = curl.get("http://localhost:1234/v1/models", { headers = headers })
                        if not response or response.status ~= 200 then
                            error("Failed to fetch models: " .. tostring(response and response.status))
                        end
                        local data = vim.json.decode(response.body)
                        for _, model in ipairs(data.data) do
                            local thinking = false
                            local tools = false
                            if string.match(model.id, "qwen") and not string.match(model.id, "vl") then
                                tools = true
                                thinking = true
                            end
                            if string.match(model.id, "qwen3%-4b%-2507") then thinking = false end
                            if string.match(model.id, "gpt%-oss") then
                                thinking = true
                                tools = true
                            end
                            ---@type CopilotChat.client.Model
                            local copilot_model = {
                                provider = "lmstudio",
                                id = model.id,
                                name = model.id,
                                streaming = true,
                                tools = tools,
                                reasoning = thinking
                            }
                            table.insert(vendors, copilot_model)
                        end
                        vim.print(vendors)
                        return vendors
                    end,
                    prepare_input = require('CopilotChat.config.providers').copilot.prepare_input,
                    prepare_output = require('CopilotChat.config.providers').copilot.prepare_output,
                    get_headers = function ()
                        return {
                            ['Content-Type'] = 'application/json',
                        }
                    end
                }
            }
        }
    end,
    config = function(_, opts)
        local chat = require("CopilotChat")

        vim.api.nvim_create_autocmd("BufEnter", {
            pattern = "copilot-chat",
            callback = function()
                vim.opt_local.relativenumber = false
                vim.opt_local.number = false
            end,
        })

        chat.setup(opts)
    end,
    keys = {
        { "<leader>ac", "<cmd>CopilotChat<cr>", desc = "Chat with Copilot" },
        { "<leader>aS", ":CopilotChatModels<cr>", desc = "Select Copilot model" },
        { "<leader>aE", ":CopilotChatExplain<cr>", desc = "Explain code with Copilot", mode = { "n", "v" } },
        { "<leader>ao", ":CopilotChatOptimize<cr>", desc = "Optimize code with CopilotChat", mode = { "n", "v" } },
        { "<leader>ax", function () return require("CopilotChat").reset() end, desc = "Clear chat", mode = { "n", "v" } },
        { "<leader>ap", function() require("CopilotChat").select_prompt() end, desc = "Prompt Actions (CopilotChat)", mode = { "n", "v" } },
    }
}
