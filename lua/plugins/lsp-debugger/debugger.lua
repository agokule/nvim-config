return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'nvim-neotest/nvim-nio'
    },
    config = function()
        local dap = require 'dap'
        dap.set_exception_breakpoints({ "raised", "uncaught" })
        dap.set_log_level('TRACE')

        dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
                command = "codelldb",
                args = { "--port", "${port}" },
            },
        }

        dap.configurations.c = {
            {
                name = 'Run executable (Codelldb)',
                type = 'codelldb',
                request = 'launch',
                -- This requires special handling of 'run_last', see
                -- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
                program = function()
                    local path = vim.fn.input({
                        prompt = 'Path to executable: ',
                        default = vim.fn.getcwd() .. '/',
                        completion = 'file',
                    })

                    return (path and path ~= '') and path or dap.ABORT
                end,
            },
            {
                name = 'Run executable with arguments (Codelldb)',
                type = 'codelldb',
                request = 'launch',
                -- This requires special handling of 'run_last', see
                -- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
                program = function()
                    local path = vim.fn.input({
                        prompt = 'Path to executable: ',
                        default = vim.fn.getcwd() .. '/',
                        completion = 'file',
                    })

                    return (path and path ~= '') and path or dap.ABORT
                end,
                args = function()
                    local args_str = vim.fn.input({
                        prompt = 'Arguments: ',
                    })
                    return vim.split(args_str, ' +')
                end,
            },
            {
                name = 'Attach to process (Codelldb)',
                type = 'codelldb',
                request = 'attach',
                processId = require('dap.utils').pick_process,
            },
        }
        dap.configurations.cpp = dap.configurations.c
        vim.fn.sign_define('DapBreakpoint', { text = '🔴' })
    end,
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
