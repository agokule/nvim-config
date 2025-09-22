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
