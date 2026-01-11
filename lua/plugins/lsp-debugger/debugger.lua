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
                name = 'Compile current file with g++ and run executable (Codelldb)',
                type = 'codelldb',
                request = 'launch',
                program = function ()
                    local path = vim.fn.expand("%:p")
                    local exepath = vim.fn.fnamemodify(path, ":r")
                    if vim.fn.has('win32') == 1 then
                        exepath = exepath .. '.exe'
                    end
                    local output = vim.system({
                        "g++", '-g', "-Wall", '-static', '-std=c++17',
                        path, '-o', exepath
                    }):wait()

                    if output.stdout ~= nil and output.stdout ~= '' then
                        vim.notify("stdout for compile cmd:\n" .. output.stdout)
                    end
                    if output.stderr ~= nil and output.stderr ~= '' then
                        vim.notify("stderr for compile cmd:\n" .. output.stderr)
                    end

                    if output.code ~= 0 then
                        vim.print("Compile command failed with code " .. output.code)
                        return dap.ABORT
                    end

                    return exepath
                end
            },
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
        vim.fn.sign_define('DapStopped', { text = '→', texthl = "DapStoppedLineGutter", linehl = "DapStoppedLine" })
        vim.api.nvim_set_hl(0, "DapStoppedLineGutter", { fg = "#ff5f3c" })
        vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = '#781800' })

    end,
}
