return {
    'mfussenegger/nvim-dap',
    dependencies = {
        -- Creates a beautiful debugger UI
        'rcarriga/nvim-dap-ui',

        -- Installs the debug adapters for you
        'williamboman/mason.nvim',

        'nvim-neotest/nvim-nio'
    },
    config = function()
        local dap = require 'dap'
        dap.set_exception_breakpoints({ "raised", "uncaught" })
        dap.set_log_level('TRACE')

        require('dap').adapters.cppdbg = {
            id = 'cppdbg',
            type = 'executable',
            command =
                "OpenDebugAD7.cmd", -- mason should have this installed and in path specifically for neovim
            options = {
                detached = false
            }
        }
        require("dap").configurations.cpp = {
            {
                name = "Launch file",
                type = "cppdbg",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopAtEntry = false,
                setupCommands = {
                    {
                        text = '-enable-pretty-printing',
                        description = 'enable pretty printing',
                        ignoreFailures = false
                    },
                },
            },
        }

        require('dap').configurations.c = require('dap').configurations.cpp
        vim.fn.sign_define('DapBreakpoint', { text = '🔴' })
    end,
    event = "BufEnter",
    keys = {
        { '<F5>', function() require('dap').continue() end, desc = 'Debug: Start/Continue' },
        { '<F1>', function() require('dap').step_into() end, desc = 'Debug: Step Into' },
        { '<F2>', function() require('dap').step_over() end, desc = 'Debug: Step Over' },
        { '<F3>', function() require('dap').step_out() end, desc = 'Debug: Step Out' },
        { '<leader>b', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
        { '<leader>B', function()
            require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end, desc = 'Debug: Set Breakpoint' }
    }
}
