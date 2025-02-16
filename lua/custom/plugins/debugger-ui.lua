return {
    -- :h nvim-dap-ui
    'rcarriga/nvim-dap-ui',
    dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio"
    },
    keys = {
        -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
        { '<F7>', function () require('dapui').toggle() end, desc = 'Debug: See last session result.' },
    },
    event = "BufRead",
    config = function()
        local dap = require 'dap'
        local dapui = require('dapui')
        dapui.setup()
        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end
    end,
}
