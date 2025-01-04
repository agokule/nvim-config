return {
    -- :h nvim-dap-ui
    'rcarriga/nvim-dap-ui',
    opts = {
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
            icons = {
                pause = '',
                play = '▶',
                step_into = '',
                step_over = '',
                step_out = '',
                step_back = '',
                run_last = '▶▶',
                terminate = ' ',
                disconnect = '',
            },
        },
    },
    keys = {
        -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
        { '<F7>', require('dapui').toggle, desc = 'Debug: See last session result.' },
    },
    init = function()
        local dapui = require('dapui')
        local dap = require 'dap'
        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close
    end,
}
